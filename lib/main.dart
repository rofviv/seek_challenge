import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    OverlaySupport.global(
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
