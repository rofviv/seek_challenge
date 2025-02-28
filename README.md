## SEEK CHALLENGE

---

### Technologies

- Flutter 3.24.5
- Dart 3.5.4
- Kotlin 1.9
- Android SDK 34

### Features

- Native authentication using fingerprint or passcode entry (Flutter - Kotlin using pigeon and method channels)
- QR code scanning using the mobile_scanner library

### Architecture - Navigation - Dependency Injection

MVC with the flutter_modular package 6.3.3

### State Management

BLoC 9.0.0

### Platform

Released only Android

[![Download APK](https://img.shields.io/badge/Download-APK-green.svg?style=for-the-badge&logo=android)](https://github.com/rofviv/seek_challenge/raw/refs/heads/master/app-release.apk)

### Launch the app in developer mode

To start the application in developer mode, run the following commands:

```sh
flutter pub get
flutter run
```

### Screenshots

| Launcher                                                                                                               | Authentication                                                                                                            | Fingerprint                                                                                                         |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/rofviv/seek_challenge/blob/master/assets/screenshots/launcher.jpeg?raw=true" width="200"> | <img src="https://github.com/rofviv/seek_challenge/blob/master/assets/screenshots/authenticate.png?raw=true" width="200"> | <img src="https://github.com/rofviv/seek_challenge/blob/master/assets/screenshots/finger.png?raw=true" width="200"> |

| Pattern                                                                                                             | QR Scanner                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/rofviv/seek_challenge/blob/master/assets/screenshots/patron.png?raw=true" width="200"> | <img src="https://github.com/rofviv/seek_challenge/blob/master/assets/screenshots/qr-scan.jpeg?raw=true" width="200"> |
