part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthBiometricEvent extends AuthEvent {
  final bool success;
  final String? errorMessage;

  const AuthBiometricEvent(this.success, this.errorMessage);
}
