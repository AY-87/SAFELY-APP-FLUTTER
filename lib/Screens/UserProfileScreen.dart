import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/editprofile.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/auth_services.dart';


class UserProfileScreen extends StatefulWidget {
  static const String screenRoute = 'UserProfileScreen';

  final String firstName;
  final String lastName;
  final String healthProblems;
  final String address;
  final String blood_type;

  const UserProfileScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.healthProblems,
    required this.address,
    required this.blood_type,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final auth = AuthServices();

  late String _firstName;
  late String _lastName;
  late String _healthProblems;
  late String _address;
  late String _blood_type;

  Future<User>? _userData;

  @override
  void initState() {
    super.initState();
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    _healthProblems = widget.healthProblems;
    _address = widget.address;
    _blood_type = widget.blood_type;
    _userData = getUserData();
  }

  Future<User> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.get(
      Uri.parse('https://safelyy.store/api/showdata'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ), onPressed: () {
          Navigator.pushNamed(context, HomeScreen.screenRoute);
        },
        ),
      ),
      body: FutureBuilder<User>(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.drive_file_rename_outline_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('Full Name:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70
                    ),
                  ),


                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('Address:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    snapshot.data!.address,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70
                    ),
                  ),


                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                        Icons.bloodtype,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('Blood Type:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.blood_type,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70
                    ),
                  ),

                  SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety_sharp,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('Health Problems:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.healthProblems,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70
                    ),
                  ),



                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, EditProfileUI.screenRoute);
        },

        child: Icon(Icons.edit),
        backgroundColor: Color(0xFFffae46),
      ),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String healthProblems;
  final String address;
  final String blood_type;

  User({
    required this.firstName,
    required this.lastName,
    required this.healthProblems,
    required this.address,
    required this.blood_type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      healthProblems: json['another_health_problem'] ?? '',
      address: json['Address'] ?? '',
      blood_type: json['blood_type'] ?? '',
    );
  }
}



