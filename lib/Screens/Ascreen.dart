import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/auth_services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Ascreen extends StatefulWidget {
  @override
  _AscreenState createState() => _AscreenState();
}

class _AscreenState extends State<Ascreen> {
  final auth = AuthServices();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 60), () {
      sendLocation(context);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool isLocationSent = false;

  Future<void> sendLocation(BuildContext context) async {
    if (isLocationSent) return;

    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final geolocator = Geolocator();
    LocationPermission permission;

    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          print('Location permission denied');
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      final latitude = position.latitude;
      final longitude = position.longitude;

      final googleMapsLink =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      http.post(
        Uri.parse('https://safelyy.store/api/Store_Notify'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value',
        },
        body: {'notification': googleMapsLink},
      ).then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('An alert has been sent to your emergency contacts.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        print('Error sending location: $error');
      });

      setState(() {
        isLocationSent = true;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ooo.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Are you Ok?',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Our sensors detected unusual speed and stop,'
                              '  we just want to make sure everything is ok.',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    sendLocation(context); // Call the sendLocation() function here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    'Call Emergency',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  timer?.cancel(); // Cancel the timer here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
