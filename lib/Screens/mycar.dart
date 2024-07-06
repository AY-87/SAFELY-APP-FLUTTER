import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/car.dart';
import 'package:udemy_flutter/Screens/homescreen.dart';
import 'package:udemy_flutter/auth_services.dart';

class MyCar extends StatefulWidget {
  static const String screenRoute = 'mycar';

  @override
  _MyCarState createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  final auth = AuthServices();

  late Future<List<Car>> _carData;

  @override
  void initState() {
    super.initState();
    _carData = getCarData();
  }

  Future<List<Car>> getCarData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    print('Access token: $value');

    final response = await http.get(
      Uri.parse('https://safelyy.store/api/carShow'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final carsData = jsonData['cars'] as List<dynamic>;

      List<Car> cars = [];

      carsData.forEach((carData) {
        final car = Car(
          id: carData['plate_NO'],
          model: carData['model'],
          color: carData['color'],
          plate_NO: carData['plate_NO'],
        );
        print('Car model: ${car.model}');
        print('Car color: ${car.color}');
        print('Car plate_NO: ${car.plate_NO}');
        cars.add(car);
      });

      setState(() {
        _carData = Future.value(cars);
      });

      return cars;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> deleteCar(String plateNO) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    print('Access token: $value');

    final response = await http.delete(
      Uri.parse('https://safelyy.store/api/carDelete/$plateNO'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
    );

    print('Delete response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      if (status == 'success') {
        setState(() {
          _carData = getCarData();
        });
      } else {
        throw Exception('Failed to delete car');
      }
    } else {
      throw Exception('Failed to delete car');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('My Cars'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ),
          onPressed: () {
            print('Navigating back to HomeScreen');
            Navigator.pushNamed(context, HomeScreen.screenRoute);
          },
        ),
      ),
      body: FutureBuilder<List<Car>>(
        future: _carData,
        builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (BuildContext context, int index) {
                final car = cars[index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Car Model:',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        car.model,
                        style: TextStyle(fontSize: 24, color: Colors.white70),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Icon(
                            Icons.format_color_fill,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Car Color:',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        car.color,
                        style: TextStyle(fontSize: 24, color: Colors.white70),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Car Plate Number:',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        car.plate_NO,
                        style: TextStyle(fontSize: 24, color: Colors.white70),
                      ),
                      SizedBox(height: 16),

                      // Delete button
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
                                    title: const Text(
                                      'Delete Car',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this car?',
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
                                          deleteCar(car.plate_NO);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
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
                      const Divider(color: Colors.white),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, carscreen.screenRoute);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFffae46),
      ),
    );
  }
}

class Car {
  final String id;
  final String model;
  final String color;
  final String plate_NO;

  Car({
    required this.id,
    required this.model,
    required this.color,
    required this.plate_NO,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['plate_NO'],
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      plate_NO: json['plate_NO'] ?? '',
    );
  }
}
