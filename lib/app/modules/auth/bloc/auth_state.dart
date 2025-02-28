part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool loginSuccess;
  final String? errorMessage;

  const AuthState({
    this.loginSuccess = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? loginSuccess,
    String? errorMessage,
  }) {
    return AuthState(
      loginSuccess: loginSuccess ?? this.loginSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        loginSuccess,
        errorMessage,
      ];
}
