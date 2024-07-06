import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/auth_services.dart';
import 'package:http/http.dart' as http;

import 'UserProfileScreen.dart';


class EditProfileUI extends StatefulWidget {
  static const String screenRoute = 'EditProfileUI';
  const EditProfileUI({Key? key}) : super(key: key);


  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  final auth = AuthServices();

  String first_name = '';
  String last_name = '';
  // String _email = '';
  // String _password = '';
  String another_health_problem = '';
  String Address = '';
  String blood_type = '';



  Future<void> updatedataPressed() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    Map<String, dynamic> requestBody = {};

    if (first_name.isNotEmpty) {
      requestBody["first_name"] = first_name;
    }
    if (last_name.isNotEmpty) {
      requestBody["last_name"] = last_name;
    }
    if (another_health_problem.isNotEmpty) {
      requestBody["another_health_problem"] = another_health_problem;
    }
    if (Address.isNotEmpty) {
      requestBody["Address"] = Address;
    }
    if (blood_type.isNotEmpty) {
      requestBody["blood_type"] = blood_type;
    }

    if (requestBody.isNotEmpty) {
      http.put(
        Uri.parse('https://safelyy.store/api/updateData'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: requestBody,
      ).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF2c363b),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2c363b),
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFFffae46),
            ), onPressed: () {
            Navigator.pushNamed(context, UserProfileScreen.screenRoute);
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    ''
                                )
                            )
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Colors.white
                              ),
                              color: Colors.amber,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )
                      )
                    ],
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter your First Name',
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
                          first_name = value;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your Last Name',
                          labelText: 'Last Name',labelStyle: TextStyle(
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
                          last_name = value;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Address',
                          labelText: 'Address',
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
                          Address = value;
                        },
                      ),


                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Blood Type',
                          labelText: 'Blood Type',
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
                          blood_type = value;
                        },
                      ),




                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Health Problems',
                          labelText: 'Health problems',
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
                          another_health_problem = value;
                        },
                      ),



                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          updatedataPressed();
                          Navigator.pushNamed(context, UserProfileScreen.screenRoute);
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