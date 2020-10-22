import 'package:base_app/core/constant/enum.dart';
import 'package:base_app/core/model/exception/unauthorized.dart';
import 'package:base_app/core/model/viewstate_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel with ChangeNotifier {
  bool _disposed = false;

  ViewState _viewState;

  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  BaseViewModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle;

  ViewState get viewState => _viewState;

  bool get isBusy => _viewState == ViewState.busy;

  bool get isIdle => _viewState == ViewState.idle;

  bool get isEmpty => _viewState == ViewState.empty;

  bool get isError => _viewState == ViewState.error;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setError(dynamic e, dynamic stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ViewStateErrorType.networkError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE) {
        message = e.error;
      } else if (e.type == DioErrorType.CANCEL) {
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        if (e is UnAuthorizedException) {
          stackTrace = null;
          errorType = ViewStateErrorType.unauthorizedError;
        }
      }
    }
    _viewStateError = ViewStateError(
      errorType,
      message: message ?? '',
    );
    viewState = ViewState.error;
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError){}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
