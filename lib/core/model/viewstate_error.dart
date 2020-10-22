import 'package:base_app/core/constant/enum.dart';

class ViewStateError {
  ViewStateErrorType _errorType;
  String message;

  ViewStateError(this._errorType, {this.message}) {
    _errorType ??= ViewStateErrorType.defaultError;
    message ??= message ?? '';
  }

  ViewStateErrorType get errorType => _errorType;

  bool get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  bool get isNetworkTimeOut => _errorType == ViewStateErrorType.networkError;
  bool get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message}';
  }
}