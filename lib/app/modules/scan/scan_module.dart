import 'package:flutter_modular/flutter_modular.dart';
import 'package:seek_challenge/app/modules/scan/bloc/scan_bloc.dart';

import 'scan_widget.dart';

class ScanModule extends Module {
  static String route = '/scan';

  @override
  void binds(i) {
    i.addSingleton<ScanBloc>(() => ScanBloc());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const ScanWidget());
  }
}
