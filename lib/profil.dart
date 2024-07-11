import 'package:flutter/material.dart';
import 'login.dart'; // Import the Login screen
import 'edit.dart'; // Import the Edit screen
import 'menu.dart'; // Import the Menu screen

class Profil extends StatefulWidget {
  final String name;
  final String username;
  final String password;

  Profil({required this.name, required this.username, required this.password});

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool _isLoading = false;

  void _logout() {
    setState(() {
      _isLoading = true;
    });

    // Simulate logout process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Edit(currentUsername: widget.username, password: widget.password)),
    );
  }

  int _selectedIndex = 1; // Set default selected index for Profil

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Menu()), // Navigate to Menu
      );
    } else if (index == 1) {
      // Tetap di halaman Profil
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout function
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'), // Path to your back icon image
          onPressed: () {
            Navigator.pop(context); // Back action
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff9a9e), Color(0xFFfecfef), Color(0xFFfecfef)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'E - BENGKEL',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rollerfont', // Ensure the font is added in pubspec.yaml
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PROFIL DATA\nUser',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Image.asset(
                    'assets/images/orang.png',
                    width: 200, // Set a fixed width to ensure it fits within the container
                    height: 200, // Set a fixed height to ensure it fits within the container
                    fit: BoxFit.cover, // Ensure the image fits within the container
                  ),
                  SizedBox(height: 16),
                  _buildPillBox('Name: ${widget.name}'),
                  _buildPillBox('Username: ${widget.username}'),
                  _buildPillBox('Password: ${widget.password}'),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        onTap: _editProfile,
                        child: Text(
                          'Edit Profil',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _showLogoutConfirmationDialog,
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      }),
                      foregroundColor:
                      MaterialStateProperty.resolveWith((states) =>
                      Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                      ),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      elevation:
                      MaterialStateProperty.resolveWith((states) => 0),
                      overlayColor:
                      MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      }),
                      shadowColor:
                      MaterialStateProperty.resolveWith((states) =>
                      Colors.transparent),
                      tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
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
                          'Log Out',
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/icon1.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/profil.png')),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPillBox(String info) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.3),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50.0), // Pillbox shape
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(info),
        ],
      ),
    );
  }
}
