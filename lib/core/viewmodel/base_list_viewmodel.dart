import 'package:base_app/core/viewmodel/base_viewmodel.dart';

abstract class BaseListViewModel<T> extends BaseViewModel {
  List<T> list = [];

  Future<void> initData() async {
    setBusy();
  }

  Future<void> refresh() async {
    try {
      final List<T> data = await loadData();
      if(data.isEmpty){
        list.clear();
        setEmpty();
      }else{
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
      }
    }catch (e, s){
      setError(e, s);
    }
  }

  Future<List<T>> loadData();

  void onCompleted(List<T> data){}
}