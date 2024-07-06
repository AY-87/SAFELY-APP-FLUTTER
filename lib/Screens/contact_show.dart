import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/contacts.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/auth_services.dart';

class contactshow extends StatefulWidget {
  static const String screenRoute = 'contactshow';

  @override
  _contactshowState createState() => _contactshowState();
}

class _contactshowState extends State<contactshow> {
  final auth = AuthServices();
  late Future<List<Contact>> _contactData;

  @override
  void initState() {
    super.initState();
    _contactData = getContactData();
  }

  Future<List<Contact>> getContactData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    print('Access token: $value');

    final response = await http.get(
      Uri.parse('https://safelyy.store/api/emergency-contacts-show'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData is Map && jsonData.containsKey('emergency_contact')) {
        final contactsData = jsonData['emergency_contact'] as List<dynamic>?;

        if (contactsData != null) {
          List<Contact> contacts = [];
          contactsData.forEach((contactData) {
            final contact = Contact(
              first_name: contactData['first_name'] ?? '',
              last_name: contactData['last_name'] ?? '',
              phone_number: contactData['phone_number'] ?? '',
              relationship: contactData['pivot']['relationship'] ?? '',
            );
            print('first name: ${contact.first_name}');
            print('last name: ${contact.last_name}');
            print('phone number: ${contact.phone_number}');
            print('Relationship: ${contact.relationship}');
            contacts.add(contact);
          });

          setState(() {
            _contactData = Future.value(contacts);
          });
          return contacts;
        } else {
          throw Exception('Contacts data is null');
        }
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> deleteContact(String phone_number) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    print('Access token: $value');

    final url = 'https://safelyy.store/api/emergency-contact-delete/{phone_number}';
    print('Delete URL: $url');

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'phone_number': phone_number}),
    );

    print('Delete response status code: ${response.statusCode}');
    print('Delete response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Contact deleted successfully');
      setState(() {
        _contactData = getContactData();
      });
    } else {
      throw Exception('Failed to delete contact');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('My Contacts'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ),
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.screenRoute);
          },
        ),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactData,
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Full Name:',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${contact.first_name} ${contact.last_name}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Phone Number:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        contact.phone_number,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Relationship:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        contact.relationship,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFFffae46),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: const Color(0xFF2c363b),
                                    title: Text(
                                      'Delete Contact',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete this contact?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          deleteContact(contact.phone_number);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(color: Colors.white),
                    ],
                  ),
                );
              },
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
          Navigator.pushNamed(context, contactadd.screenRoute);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFffae46),
      ),
    );
  }
}

class Contact {
  final String first_name;
  final String last_name;
  final String phone_number;
  final String relationship;

  Contact({
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.relationship,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      phone_number: json['phone_number'] ?? '',
      relationship: json['relationship'] ?? '',
    );
  }
}
