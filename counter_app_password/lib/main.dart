import 'package:flutter/material.dart';
import 'dart:io';

// ACTION: uncomment this code
// import 'package:encrypt/encrypt.dart' as encrypt; 

// ACTION: uncomment this code
// final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
// final _iv = encrypt.IV.fromLength(16);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, String> _credentials = {};

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

Future<void> _loadCredentials() async {
  try {
    final file = File('password.txt');
    final lines = await file.readAsLines();
    final credentials = <String, String>{};

    // ACTION: uncomment this code
    // final encrypter = encrypt.Encrypter(encrypt.AES(_key));

    for (var line in lines) {
      final parts = line.split(':');

      // ACTION: uncomment this code
      // if (parts.length == 3) {
      //   final username = parts[0];
      //   final ivBase64 = parts[1];
      //   final encryptedPasswordBase64 = parts[2];
      //   final iv = encrypt.IV.fromBase64(ivBase64);
      //   final encryptedPassword = encrypt.Encrypted.fromBase64(encryptedPasswordBase64);
      //   final decryptedPassword = encrypter.decrypt(encryptedPassword, iv: iv);  
      //   credentials[username] = decryptedPassword;
      // }

      // Action: comment this if code block
      if (parts.length == 2) {
        final username = parts[0];
        final password = parts[1];
        credentials[username] = password;
      }

    }
      setState(() {
        _credentials = credentials;
      });
    } catch (e) {
      print('Error reading password.txt: $e');
    }
  }

  void _attemptLogin() {
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    if (_credentials.containsKey(enteredUsername) &&
        _credentials[enteredUsername] == enteredPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CounterApp()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _attemptLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium ??
                  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}






