// dart run pigeon --input pigeons/biometric_api.dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: './lib/pigeon/kotlin/biometric_api.g.dart',
    kotlinOut:
        './android/app/src/main/java/io/flutter/plugins/BiometricApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'io.flutter.plugins',
    ),
  ),
)

@HostApi()
abstract class BiometricHostApi {
  bool isBiometricAvailable();
  void showBiometricPrompt(String title, String description);
}
