import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/car.dart';
import 'package:udemy_flutter/Screens/contact_show.dart';
import 'package:udemy_flutter/Screens/contacts.dart';
import 'package:udemy_flutter/Screens/editprofile.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:app_settings/app_settings.dart';
import '../auth_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'UserProfileScreen.dart';
import 'mycar.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  static const String screenRoute = 'SettingsPage';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final auth = AuthServices();
  String feedback = '';



  Future<void> sendFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    print('Sending feedback...');
    print('Feedback value: $feedback');
    print('Access token value: $value');

    if (feedback.isNotEmpty) {
      http.post(
        Uri.parse('https://safelyy.store/api/feedback'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value',
        },
        body: {
          "feedback": "$feedback",
        },
      ).then((response) {
        print('Feedback Sent');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        _showSnackBar("Thanks for your feedback");
      }).catchError((error) {
        print('Error sending feedback: $error');
      });
    } else {
      print('Feedback is empty');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    print('Token saved: $value');
  }

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        centerTitle: true,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ), onPressed: () {
          Navigator.pushNamed(context, HomeScreen.screenRoute);
        },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                    Icons.person,
                    color: Colors.white
                ),
                SizedBox(width: 10),
                Text("Account", style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
              ],
            ),


            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildAccountOption1(context, 'Edit profile'),
            buildAccountOption2(context, 'Edit car information'),
            buildAccountOption3(context, 'Edit contacts'),
            // buildAccountOption(context, 'Change Blood Type'),
            const SizedBox(height: 15),
            Row(
              children: const [
                Icon(
                    Icons.miscellaneous_services,
                    color: Colors.white
                ),
                SizedBox(width: 10),
                Text("Services", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,
                    color: Colors.white))
              ],
            ),


            const Divider(height: 20, thickness: 1),
            buildAccountOption4(context, 'Bluetooth settings'),
            buildAccountOption5(context, 'Location settings'),
            const SizedBox(height: 20),
            Row(
              children: const [
                Icon(
                    Icons.miscellaneous_services,
                    color: Colors.white
                ),
                SizedBox(width: 10),
                Text("Contact us", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,
                    color: Colors.white))
              ],
            ),


            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildAccountOption6(context, 'About us'),
            buildAccountOption7(context, 'Report a problem'),
            buildAccountOption8(context, 'Feedback'),
            const SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: const Color(0xFFffae46),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.screenRoute);
                  },
                  child: const Text("Sign out", style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.2,
                      color: Colors.white
                  ),)
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value,
      Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white
          )),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.amber,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

//////////////////////////////////////////////////////////////////////

    //Edit profile
  GestureDetector buildAccountOption1(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UserProfileScreen.screenRoute);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }




  /////////////////////////////////////////////////////////
  // Edit car information

  GestureDetector buildAccountOption2(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyCar.screenRoute);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////
  // Edit contacts


  GestureDetector buildAccountOption3(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, contactshow.screenRoute);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }


///////////////////////////////////////////////////////////////////////
  //bluetooth

  GestureDetector buildAccountOption4(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        AppSettings.openBluetoothSettings();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }


/////////////////////////////////////////////////////////////////////////
//location

  GestureDetector buildAccountOption5(BuildContext context, String title) {
    return GestureDetector( //location
      onTap: () {
        AppSettings.openLocationSettings();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }





  GestureDetector buildAccountOption6(BuildContext context, String title) {
    return GestureDetector( //aboutus
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                data: ThemeData(
                  // Customize the colors here
                  primaryColor: Colors.white, // Color of the dialog title
                  accentColor: Colors.white, // Color of the buttons
                ),
                child: AlertDialog(
                  backgroundColor: const Color(0xFF2c363b),
                  title: Text(
                    'SAFELY',
                    style: TextStyle(color: Colors.white), // Color of the dialog title text
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'We aim to deploy this system to enhance road safety and emergency response measures, potentially saving lives and minimizing response times in critical situations.',
                        style: TextStyle(color: Colors.white), // Color of the dialog content text
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white), // Color of the button text
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        const url = 'https://safelyy.store/';
                        launch(url);
                      },
                      child: const Text(
                        'Visit Our Website',
                        style: TextStyle(color: Colors.white), // Color of the button text
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }



////////////////////////////////////////////////////////////////////////////////////
  //Report a problem

  GestureDetector buildAccountOption7(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF2c363b), // Change the background color here
              title: const Text(
                'Report a problem',
                style: TextStyle(
                  color: Colors.white, // Modify the title color here
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Send us your problem',
                      hintStyle: TextStyle(
                        color: Colors.grey, // Modify the hint text color here
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.grey, // Modify the input text color here
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white, // Modify the close button text color here
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _save('0');
                    sendFeedback();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white, // Modify the send button text color here
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////
  //Feedback



  GestureDetector buildAccountOption8(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF2c363b), // Change the background color here
              title: const Text(
                'Insert feedback',
                style: TextStyle(
                  color: Colors.white, // Modify the title color here
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      feedback = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your feedback',
                      hintStyle: TextStyle(
                        color: Colors.grey, // Modify the hint text color here
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.grey, // Modify the input text color here
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white, // Modify the close button text color here
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _save('0');
                    sendFeedback();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white, // Modify the send button text color here
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
