import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/contact_show.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/Screens/mycar.dart';
import 'package:udemy_flutter/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/contactshow.dart';


class contactadd extends StatefulWidget {
  static const String screenRoute = 'contactadd';

  @override
  State<contactadd> createState() => _contactadd();
}

class _contactadd extends State<contactadd> {

  final auth = AuthServices();

  //String contact_name = '';
  String phone_number = '';
  String relationship = '';


  Future<void> addcontactData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    if (phone_number.isNotEmpty && relationship.isNotEmpty) {
      http.post(
          Uri.parse('https://safelyy.store/api/addEmergencyContact'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $value'
          },
          body: {
            "phone_number": "$phone_number",
            "relationship": "$relationship",
          }
      ).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => contactshow()),
          );

        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('Add Contacts'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ), onPressed: () {
          Navigator.pushNamed(context, contactshow.screenRoute);
        },
        ),
      ),

      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    // TextField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Contact Name',
                    //     hintText: 'Enter Contact Name',
                    //     labelStyle: TextStyle(
                    //       color: Colors.white70,
                    //     ),
                    //     hintStyle: TextStyle(
                    //       color: Colors.white70,
                    //     ),
                    //   ),
                    //   style: const TextStyle(
                    //     color: Colors.white70,
                    //   ),
                    //   onChanged: (value) {
                    //     contact_name = value;
                    //   },
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Contact Number',
                        labelText: 'Contact Number',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        phone_number = value;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Declare Member',
                        labelText: 'Member',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                      onChanged: (value) {
                        relationship = value;
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),


                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push
                          (context, MaterialPageRoute(
                          builder: (context) => contactshow(),));
                        addcontactData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFffae46),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Save",
                          style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Contact {
  //String contact_name;
  String phone_number;
  String relationship;
  Contact({//required this.contact_name,
    required this.phone_number, required this.relationship});
}
