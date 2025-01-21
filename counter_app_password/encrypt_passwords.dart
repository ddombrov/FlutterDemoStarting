import 'dart:io';
import 'package:encrypt/encrypt.dart';


void main() async {
  // Define a key (must be 32 bytes for AES)
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = IV.fromLength(16); // Random IV
  final encrypter = Encrypter(AES(key));


  // Read the existing password.txt file
  final file = File('assets/password.txt'); 
  if (await file.exists()) {
    final lines = await file.readAsLines();
    final encryptedLines = <String>[];


    // Encrypt each user's password
    for (var line in lines) {
      final parts = line.split(':');
      if (parts.length == 2) {
        final username = parts[0];
        final password = parts[1];


        // Encrypt the password
        final encrypted = encrypter.encrypt(password, iv: iv);
        // Save the username, IV, and encrypted password
        encryptedLines.add('${username}:${iv.base64}:${encrypted.base64}');
      }
    }


    // Save the encrypted passwords back to password.txt
    await file.writeAsString(encryptedLines.join('\n'));
    print('Encrypted passwords saved to password.txt');
  } else {
    print('password.txt file not found!');
  }
}
