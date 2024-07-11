import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menu.dart';
import 'register.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final String url = 'https://mobilecomputing.my.id/api_julio/login.php';

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success']) {
        // Save username and password to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', _usernameController.text);
        await prefs.setString('password', _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to connect to server')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff9a9e), Color(0xFFfecfef), Color(0xFFfecfef)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'E - BENGKEL',
                style: TextStyle(
                  fontFamily: 'RollerFont',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFbdc2e8), Color(0xFFbdc2e8), Color(0xFFe6dee9)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(10, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/regist1.png', // Ganti dengan path gambar yang sesuai
                                    width: 20, // Atur lebar gambar
                                    height: 20, // Atur tinggi gambar
                                  ),
                                  labelText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15), // Ruang antara Username dan Password
                              TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/lock.png', // Ganti dengan path gambar yang sesuai
                                    width: 20, // Atur lebar gambar
                                    height: 20, // Atur tinggi gambar
                                  ),
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 30), // Ruang antara Password dan tombol Login
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                onPressed: _login,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Colors.transparent; // Transparan untuk Ink gradient saat hover
                                    }
                                    return Colors.transparent;
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.white,
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                                  overlayColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Colors.transparent;
                                    }
                                    return Colors.transparent;
                                  }),
                                  shadowColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.transparent,
                                  ),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF30CFD0),
                                        Color(0xFF330867),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 300.0,
                                      minHeight: 50.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Don\'t have an account? Register here',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
