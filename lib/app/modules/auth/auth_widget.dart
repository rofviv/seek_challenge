import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/auth_bloc.dart';
import '../scan/scan_module.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    final authBloc = Modular.get<AuthBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "QR Code Scanner",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 40),
                Text(
                  "Let's start authenticating you",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Use your fingerprint to authenticate",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Column(
              children: [
                BlocListener<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state.loginSuccess) {
                      Modular.to.pushNamed(ScanModule.route);
                      authBloc.add(const AuthBiometricEvent(false, null));
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: authBloc,
                    builder: (context, state) {
                      return Text(
                        state.errorMessage ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      authBloc.showBiometricPrompt();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
