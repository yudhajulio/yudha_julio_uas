import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'riwayat.dart';

class Janji extends StatefulWidget {
  final Map<String, String> selectedWarna;
  final String selectedService;

  Janji({
    required this.selectedWarna,
    required this.selectedService,
  });

  @override
  _JanjiState createState() => _JanjiState();
}

class _JanjiState extends State<Janji> {
  Map<String, String> serviceDetails = {
    'jenis': 'N/A',
    'manfaat': 'N/A',
    'garansi': 'N/A',
  };
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchServiceDetails();
  }

  Future<void> fetchServiceDetails() async {
    final String url =
        'http://mobilecomputing.my.id/api_julio/get_service.php?jenis=${widget.selectedService}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            serviceDetails = Map<String, String>.from(data.first);
            isLoading = false;
          });
        } else if (data is Map && data.containsKey('message')) {
          setState(() {
            errorMessage = data['message'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Unexpected data format received from the server';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage =
          'Failed to load service details. Server responded with status code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load service details. Error: $e';
        isLoading = false;
      });
      print(e.toString());
    }
  }

  Future<void> saveAppointment() async {
    final String url = 'http://mobilecomputing.my.id/api_julio/save_janji.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'mekanik': widget.selectedWarna['mekanik'] ?? '',
          'pengecetan': widget.selectedWarna['pengecetan'] ?? '',
          'hari': widget.selectedWarna['hari'] ?? '',
          'jam': widget.selectedWarna['jam'] ?? '',
          'jenis': serviceDetails['jenis'] ?? '',
          'manfaat': serviceDetails['manfaat'] ?? '',
          'garansi': serviceDetails['garansi'] ?? '',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment saved successfully!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Riwayat()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                Text('Failed to save appointment: ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to save appointment. Server responded with status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save appointment. Error: $e')),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Selected Warna: ${widget.selectedWarna}");
    print("Selected Service: ${widget.selectedService}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFFEFEFEF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'BUAT JANJI',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rollerfont',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E - BENGKEL',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Jl. haji naim, No. 142\nJakarta barat',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset(
                    'assets/images/warna2.png',
                    height: 150,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Jenis: ${serviceDetails['jenis'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Manfaat: ${serviceDetails['manfaat'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Garansi: ${serviceDetails['garansi'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Mekanik: ${widget.selectedWarna['mekanik'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pengecetan: ${widget.selectedWarna['pengecetan'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Hari: ${widget.selectedWarna['hari'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Jam: ${widget.selectedWarna['jam'] ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: saveAppointment,
                    child: Text('Buat Janji'),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Riwayat()),
                      );
                    },
                    child: Text('Riwayat'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
