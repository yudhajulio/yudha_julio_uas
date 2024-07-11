import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  final String url = 'https://mobilecomputing.my.id/api_julio/register.php';

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
        'name': _nameController.text,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
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
                                controller: _nameController,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/avatar.png', // Ganti dengan path gambar yang sesuai
                                    width: 20, // Atur lebar gambar
                                    height: 20, // Atur tinggi gambar
                                  ),
                                  labelText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15), // Ruang antara Name dan Username
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
                              SizedBox(height: 30), // Ruang antara Password dan tombol Register
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                onPressed: _register,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.hovered)) {
                                      return Colors.transparent; // Transparan untuk Ink gradient saat hover
                                    }
                                    return Colors.transparent;
                                  }),
                                  foregroundColor: WidgetStateProperty.resolveWith(
                                        (states) => Colors.white,
                                  ),
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 70),
                                  ),
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                  elevation: WidgetStateProperty.resolveWith(
                                        (states) => 0,
                                  ),
                                  overlayColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.hovered)) {
                                      return Colors.transparent;
                                    }
                                    return Colors.transparent;
                                  }),
                                  shadowColor: WidgetStateProperty.resolveWith(
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
                                      'Register',
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
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Already have account? Login here',
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
