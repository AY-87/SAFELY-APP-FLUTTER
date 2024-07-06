import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';
import 'package:udemy_flutter/EnableBluetooth_screen.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';

class EnableLocationScreen extends StatelessWidget {
  static const String screenRoute = 'EnableLocationScreen';

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/WhatsApp Image 2023-04-09 at 10.05.04 PM.jpeg',),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0,),
                  color: Colors.white,
                ),
                child:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please allow location service to continue using the app!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                child: Text('Allow',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  AppSettings.openLocationSettings();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFffae46),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(onPressed: () {
                              Navigator.push
                                (context, MaterialPageRoute(
                                  builder: (context) => EnableBluetoothScreen()),);
                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: Text('Continue',
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