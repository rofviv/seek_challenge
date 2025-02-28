import 'package:flutter_modular/flutter_modular.dart';

import 'modules/modules.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(SplashModule.route, module: SplashModule());
    r.module(AuthModule.route, module: AuthModule());
    r.module(ScanModule.route, module: ScanModule());
  }
}
