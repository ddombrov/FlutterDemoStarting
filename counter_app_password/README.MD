Setup:
1. Open VS Code, connect to WSL
2. Go to your coding/cis4030 folder
3. it clone https://github.com/ddombrov/FlutterDemoStarting.git
3. cd FlutterDemoStarting/counter_app_password

Run the Plaintext Password System:
1. flutter pub get
2. flutter run

Encrypted Password System:
1. dart encrypt_passwords.dart
2. Uncomment and comment applicable lines
3. flutter pub get
4. flutter run

Troubleshooting:
If issues with running:
rm -rf build
flutter pub get
flutter run

If issues with encryption: 
flutter pub get 
flutter clean
flutter pub get
dart encrypt_passwords.dart

