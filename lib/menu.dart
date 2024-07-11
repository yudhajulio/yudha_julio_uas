import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'riwayat.dart'; // Import halaman riwayat
import 'janji.dart'; // Import halaman janji
import 'profil.dart'; // Import halaman profil
import 'service.dart'; // Import service screen
import 'warna.dart'; // Import Warna screen

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String _username = '';
  String _name = 'Default Name';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'pengguna';
      _name = prefs.getString('name') ?? 'Default Name';
      _password = prefs.getString('password') ?? '';
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Tetap di halaman Menu
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profil(name: _name, username: _username, password: _password)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Halaman tidak tersedia')));
    }
  }

  Widget _buildMenuItem(String title, String imagePath, Widget destination) {
    return GestureDetector(
      onTap: () {
        if (title == 'Service') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Service()),
          );
        } else if (title == 'Cat Mobil') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Warna()),
          );
        } else if (title == 'Janji') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Janji(selectedWarna: {}, selectedService: '')),
          );
        } else if (title == 'Riwayat') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Riwayat()),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10), // Space below the image
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E - BENGKEL',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Rollerfont',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang Di E - BENGKEL',
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.8),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hallo, $_username',
                      style: TextStyle(color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profil(name: _name, username: _username, password: _password)),
                      );
                    },
                    child: Image.asset(
                      'assets/images/avatar.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Silahkan Pilih Menu Yang Anda Di Inginkan',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ebengkel.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 6),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25.0,
                crossAxisSpacing: 25.0,
                children: [
                  _buildMenuItem('Service', 'assets/images/mekanik.png', Service()),
                  _buildMenuItem('Cat Mobil', 'assets/images/warna.png', Warna()),
                  _buildMenuItem('Janji', 'assets/images/orang.png', Janji(selectedWarna: {}, selectedService: '')),
                  _buildMenuItem('Riwayat', 'assets/images/buku.png', Riwayat()),
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
}

class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder'),
      ),
      body: Center(
        child: Text('Placeholder Page'),
      ),
    );
  }
}
