import 'package:flutter/material.dart';
import 'dart:io';


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


  // Load username and password from the file
  Future<void> _loadCredentials() async {
    try {
      final file = File('password.txt');
      final lines = await file.readAsLines();
      final credentials = <String, String>{};


      for (var line in lines) {
        final parts = line.split(':');
        if (parts.length == 2) {
          credentials[parts[0]] = parts[1];
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






