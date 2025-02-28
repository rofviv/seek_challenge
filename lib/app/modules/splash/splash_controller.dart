import 'package:flutter_modular/flutter_modular.dart';

import '../modules.dart';

class SplashController {
  SplashController() {
    _init();
  }

  void _init() {
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate(AuthModule.route);
    });
  }
}
