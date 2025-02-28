import 'package:flutter_modular/flutter_modular.dart';

import 'splash_controller.dart';
import 'splash_widget.dart';

class SplashModule extends Module {
  static String route = '/';

  @override
  void binds(i) {
    i.addSingleton<SplashController>(() => SplashController());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashWidget());
  }
}
