import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';


class EnableBluetoothScreen extends StatelessWidget {
  static const String screenRoute = 'EnableLocationScreen';

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

                          'Please connect to HC-05 bluetooth module to continue using the App!',
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
                                child: Text('Connect',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  AppSettings.openBluetoothSettings();
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
                              Navigator.pushNamed(context, HomeScreen.screenRoute);
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