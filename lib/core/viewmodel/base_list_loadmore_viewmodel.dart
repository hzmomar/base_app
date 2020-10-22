import 'package:base_app/core/viewmodel/base_list_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListLoadMoreViewModel<T> extends BaseListViewModel {
  int _currentPageNum = 1;

  int _pageSize = 1;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  set pageSize(int size){
    _pageSize = size;
  }

  @override
  Future<List<T>> refresh() async {
    try {
      _currentPageNum = 1;
      final List<T> data = await loadData(pageNum: _currentPageNum);
      if(data.isEmpty) {
        list.clear();
        setEmpty();
        _refreshController.refreshCompleted(resetFooterState: true);
      }else{
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
        _refreshController.refreshCompleted();
      }
      return data;
    }catch (e,s){
      _refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  @override
  Future<List> loadData({int pageNum});

  Future<List<T>> loadMore() async {
    try {
      final List<T> data = await loadData(pageNum: ++_currentPageNum);
      if(data.isEmpty){
        _currentPageNum--;
        _refreshController.loadNoData();
      }else{
        onCompleted(data);
        list.addAll(data);
        _refreshController.loadComplete();
        notifyListeners();
      }

      return data;
    }catch (e, s){
      _currentPageNum--;
      _refreshController.loadFailed();
      return null;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

}