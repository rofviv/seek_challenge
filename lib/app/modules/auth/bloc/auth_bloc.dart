import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../../pigeon/kotlin/biometric_api.g.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const platform = MethodChannel('io.flutter.dev/seek');

  AuthBloc() : super(const AuthState()) {
    on<AuthBiometricEvent>((event, emit) {
      emit(state.copyWith(loginSuccess: event.success, errorMessage: event.errorMessage));
    });
    _init();
  }

  void _init() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'method_biometric') {
        final res = jsonDecode(jsonEncode(call.arguments));
        add(AuthBiometricEvent(res['success'] == true, res['error'] ?? ''));
      }
    });
  }

  void showBiometricPrompt() async {
    await BiometricHostApi().showBiometricPrompt(
      'Biometric Prompt',
      'Please authenticate to continue',
    );
  }
}
