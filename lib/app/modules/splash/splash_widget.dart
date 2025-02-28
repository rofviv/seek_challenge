import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
          const CupertinoActivityIndicator(color: Colors.black),
        ],
      ),
    );
  }
}
