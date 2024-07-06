import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  static const String screenRoute = 'NotificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    getNotificationData();
  }

  Future<void> getNotificationData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    final response = await http.get(
      Uri.parse('https://safelyy.store/api/Show_Notify'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final data = jsonData['data'];

      if (data != null && data.isNotEmpty) {
        setState(() {
          notifications = List<NotificationItem>.from(data.map((item) {
            final id = item['id'] ?? 0;
            final userName = item['user_name'] ?? '';
            final notification = item['notification'] ?? '';
            return NotificationItem(id: id, userName: userName, notification: notification);
          }));
        });

        print('API Response: $jsonData');
      }
    } else {
      throw Exception('Failed to fetch notifications. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);

    final response = await http.delete(
      Uri.parse('https://safelyy.store/api/delete_Notify'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );

    print('Delete all response status code: ${response.statusCode}');
    print('Delete all response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      if (status == 'success') {
        setState(() {
          notifications.clear();
        });
        // Fetch updated notification data after clearing the list
        await getNotificationData();
      } else {
        throw Exception('Failed to delete all notifications');
      }
    } else {
      throw Exception('Failed to delete all notifications. Status code: ${response.statusCode}');
    }
  }

  void launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2c363b),
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Could not launch the URL',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
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
                    title: const Text(
                      'Delete All Notifications',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Are you sure you want to delete all notifications?',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Delete all notifications
                          deleteAllNotifications();
                          Navigator.pop(context);
                          Navigator.pushNamed(context, HomeScreen.screenRoute);
                        },
                        child: const Text(
                          'Delete All',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];

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
                    Text(
                      'This user had an accident:',
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
                  notification.userName,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Icon(
                      Icons.location_history,
                      size: 25,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'At this location:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    launchURL(notification.notification); // Replace with your desired URL
                  },
                  child: Text(
                    notification.notification,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const Divider(color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final int id;
  final String userName;
  final String notification;

  NotificationItem({
    required this.id,
    required this.userName,
    required this.notification,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? 0,
      userName: json['user_name'] ?? '',
      notification: json['notification'] ?? '',
    );
  }
}
