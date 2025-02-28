import 'package:flutter_modular/flutter_modular.dart';
import 'package:seek_challenge/app/modules/auth/bloc/auth_bloc.dart';

import 'auth_widget.dart';

class AuthModule extends Module {
  static String route = '/auth';

  @override
  void binds(i) {
    i.addSingleton<AuthBloc>(() => AuthBloc());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const AuthWidget());
  }
}
