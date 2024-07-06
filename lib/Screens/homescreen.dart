import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/Ascreen.dart';
import 'package:udemy_flutter/Screens/UserProfileScreen.dart';
import 'package:udemy_flutter/Screens/contact_show.dart';
import 'package:udemy_flutter/Screens/mycar.dart';
import 'package:udemy_flutter/Screens/settings.dart';


import 'getLocationScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  BluetoothConnection? _connection;

  BluetoothDevice? _device;

  bool _isConnected = false;


  void _connectToDevice() async {
 await   FlutterBluetoothSerial.instance.requestEnable().then((value) async {


     try {

       List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
       if (devices.isNotEmpty) {
         for (BluetoothDevice bluetoothDevice in devices) {
           if (bluetoothDevice.name == "HC-05") {
             _device = bluetoothDevice;
             break;
           }
         }
         if (_device == null) {
           print("Device not found");
           _showSnackBar("Device not found, please connect manually and press SAFELY again");
           return;
         }
         await  FlutterBluetoothSerial.instance.removeDeviceBondWithAddress(_device!.address);
         BluetoothConnection newConnection = await BluetoothConnection.toAddress(_device!.address);
         setState(() {
           _connection = newConnection;
           _isConnected = true;
         });
         print("Connected to ${_device!.name}");
         _startListening();
         _showSnackBar("Device is connected successfully");
       } else {
         print("No paired devices found");
         _showSnackBar("No paired devices found");
       }
     } catch (e) {
       print("Error connecting: $e");
       _showSnackBar("Device disconnected, please reconnect manually and press START again.");
     }
 });
  }

  void _startListening() async {
    _connection!.input?.listen((Uint8List data) {
      log(String.fromCharCodes(data));
      if(String.fromCharCodes(data).contains("accident")){

        /////////////////////////////////////////////////////// here we go ////////////////////////////////////////////////
        Navigator.push(context, MaterialPageRoute(builder: (context) => Ascreen()));
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

 // @override
  // void initState() {
  //   super.initState();
  //   _connectToDevice();
  // }


  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        centerTitle: true,
        leading: Container(), // Remove the back icon
        title: const Text(
          "Home screen",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFFffae46),
            onPressed: () {
              Navigator.push
                (context, MaterialPageRoute(
                builder: (context) => NotificationScreen(),
              ),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.bluetooth),
          //   color: Color(0xFFffae46),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Ascreen(),
          //       ),
          //     );
          //   },
          // ),
         ],
       ),


      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UserProfileScreen.screenRoute);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFffae46),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        size: 60.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ), // Profile

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: GestureDetector(
                onTap: () {
                  _save('0');
                  Navigator.pushNamed(context, MyCar.screenRoute);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFffae46),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.car_rental,
                        size: 60.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Car',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ), //car

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, contactshow.screenRoute);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFffae46),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.contacts,
                              size: 50.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Contacts',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SettingsPage.screenRoute);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFFffae46)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 50.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ), //contacts & settings
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push
              //   (context, MaterialPageRoute(
              //     builder: (context) => Ascreen(),));
              _connectToDevice();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFffae46),
              onPrimary: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'START',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
