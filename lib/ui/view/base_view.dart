import 'package:base_app/core/service/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final Function(T) onModelReady;
  final T viewModel;

  const BaseView({
    @required this.builder,
    Key key,
    this.onModelReady,
    this.viewModel,
  })  : assert(builder != null),
        super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model;

  @override
  void initState() {
    model = widget.viewModel ?? locator<T>();
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.viewModel != null
        ? ChangeNotifierProvider.value(
            value: widget.viewModel,
            child: widget.builder(context, widget.viewModel),
          )
        : ChangeNotifierProvider(
            create: (context) => model,
            child: widget.builder(context, model),
          );
  }
}

class BaseView2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(
      BuildContext context, A viewModel1, B viewModel2) builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A model1, B model2) onModelReady;

  const BaseView2({
    @required this.builder,
    @required this.model1,
    @required this.model2,
    Key key,
    this.child,
    this.onModelReady,
  })  : assert(builder != null),
        super(key: key);

  @override
  _BaseView2State<A, B> createState() => _BaseView2State<A, B>();
}

class _BaseView2State<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<BaseView2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1 ?? locator<A>();
    model2 = widget.model2 ?? locator<B>();
    if (widget.onModelReady != null) {
      widget.onModelReady(model1, model2);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: widget.builder(context, model1, model2),
    );
  }
}
