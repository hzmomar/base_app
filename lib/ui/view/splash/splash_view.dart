import 'package:base_app/core/viewmodel/startup_vm.dart';
import 'package:base_app/ui/view/base_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupVM>(
      onModelReady: (vm) => vm.handleStartUp(context),
      builder: (context, vm){
        return const Scaffold(
          backgroundColor: Colors.red,
          body: Center(
            child: Icon(Icons.add_circle, color: Colors.yellow,),
          ),
        );
      },
    );
  }
}
