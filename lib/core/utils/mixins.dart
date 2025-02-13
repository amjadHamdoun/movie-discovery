import 'package:flutter/material.dart';

mixin OnChangeDependenciesMixin<F extends StatefulWidget> on State<F> {
  bool isFirstDependency = true;
  void onChangeDependencies() {}
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstDependency) {
      return;
    }
    isFirstDependency = false;
    onChangeDependencies();
  }
}
