
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:udemy_flutter/Screens/UserProfileScreen.dart';
import 'package:udemy_flutter/login_screen.dart';
import 'package:udemy_flutter/personalinformaion_screen.dart';
import 'package:udemy_flutter/enabalelocation_screen.dart';
import 'package:udemy_flutter/Screens/editprofile.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/Screens/settings.dart';
import 'EnableBluetooth_screen.dart';
import 'Screens/Ascreen.dart';
import 'Screens/car.dart';
import 'Screens/contact_show.dart';
import 'Screens/contacts.dart';
import 'Screens/getLocationScreen.dart';
import 'Screens/mycar.dart';


void main()
{
  runApp(MYAPP());
}
class MYAPP extends StatefulWidget
{
  @override
  State<MYAPP> createState() => _MYAPPState();
}

class _MYAPPState extends State<MYAPP> {


  @override
  Widget build(BuildContext context) {


        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: EmergencyContactScreen(Contact_1: '', RelationshipContact_1: '', Contact_2: '', RelationshipContact_2: '', Contact_3: '', RelationshipContact_3: '',),
       // );

          // home: UserProfileScreen(firstName: '', lastName: '', healthProblems: '', address: '',),
          initialRoute: LoginScreen.screenRoute,
          routes: {
            LoginScreen.screenRoute: (context) => LoginScreen(),
           PersonalInformationScreen.screenRoute: (context) => PersonalInformationScreen(),
            EnableBluetoothScreen.screenRoute: (context) => EnableBluetoothScreen(),
            EnableLocationScreen.screenRoute: (context) => EnableLocationScreen(),
            HomeScreen.screenRoute: (context) => HomeScreen(),
            EditProfileUI.screenRoute: (context) => const EditProfileUI(),
            SettingsPage.screenRoute: (context) => SettingsPage(),
            contactshow.screenRoute: (context) =>   contactshow(),
           carscreen.screenRoute: (context) => carscreen(),
            MyCar.screenRoute: (context) => MyCar(),
            UserProfileScreen.screenRoute: (context) => const UserProfileScreen (firstName: '', lastName: '', healthProblems: '', address: '', blood_type: '',),
            contactadd.screenRoute: (context) => contactadd(),
            NotificationScreen.screenRoute: (context) => NotificationScreen(),
          },
        );

  }
}
