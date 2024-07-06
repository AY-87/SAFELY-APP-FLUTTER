import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/Screens/mycar.dart';
import 'package:udemy_flutter/auth_services.dart';
import 'package:http/http.dart' as http;


class carscreen extends StatefulWidget {
  static const String screenRoute = 'carscreen';

  @override
  State<carscreen> createState() => _carscreen();
}

class _carscreen extends State<carscreen> {
  final auth = AuthServices();
  String model = '';
  String color = '';
  String plate_NO = '';


  Future<void> addCarData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    if (model.isNotEmpty && color.isNotEmpty && plate_NO.isNotEmpty) {
      http.post(
        Uri.parse('https://safelyy.store/api/CarStore'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value',
        },
        body: {
          "model": "$model",
          "color": "$color",
          "plate_NO": "$plate_NO",
        },
      ).then((response) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2c363b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c363b),
        title: const Text('Add Car'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFffae46),
          ), onPressed: () {
          Navigator.pushNamed(context, MyCar.screenRoute);
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

                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Car Model',
                        hintText: 'Enter Car Model',
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
                        model = value;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Car Color',
                        labelText: 'Car Color',labelStyle: TextStyle(
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
                        color = value;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter Plate Number',
                        labelText: 'Plate Number',
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
                        plate_NO = value;
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),


                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push
                          (context, MaterialPageRoute(
                          builder: (context) => MyCar(),));
                        addCarData();
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

class Car {
  String model;
  String color;
  String plate_NO;
  Car({required this.model, required this.color, required this.plate_NO});
}
