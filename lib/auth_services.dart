import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {

  var ServerUrl = "https://safelyy.store/api/";
  var status;
  var token;

  loginData(String email, String password) async {
    final response = await http.post(
        Uri.parse('https://safelyy.store/api/userLogin'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          "email": "$email",
          "password": "$password"
        });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["access_token"]}');
      save(data["access_token"]);
    }
  }


  registerData(String first_name, String last_name, String phone_number,
      String email, String password,
      String confirm_password, String date_of_birth, String Address, bool Male,
      bool Female, bool Yes_P, bool No_P, bool yes,
      bool no, String blood_type, String another_health_problem,
      String plate_NO, String model, String color) async {
    //  String myUrl = "serverUrl/login1";
    final response = await http.post(
        Uri.parse('https://safelyy.store/api/Register'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          "first_name": "$first_name",
          "last_name": "$last_name",
          "phone_number": "$phone_number",
          "email": "$email",
          "password": "$password",
          "confirm_password": "$confirm_password",
          "date_of_birth": "$date_of_birth",
          "Address": "$Address",
          'gender': Male ? 'Male' : (Female ? 'Female' : null),
          'blood_pressure': Yes_P ? 'yes' : (No_P ? 'no' : null),
          'diabetes': yes ? 'yes' : (no ? 'no' : null),
          'blood_type': "$blood_type",
          'another_health_problem': "$another_health_problem",
          "plate_NO": "$plate_NO",
          "model": "$model",
          "color": "$color",
        });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      if (data != null) {
        print('data : ${data["error"]}');
      } else {
        print('Error: Null response from server.');
      }
    } else {
      print('data : $data');
      // save(data["access_token"]);
    }
  }

  String serverUrl = 'https://safelyy.store/api/';

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    http.Response response = await http.get(
        Uri.parse('https://safelyy.store/api/carShow'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        });
    return json.decode(response.body);
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/carDelete/$id";
    http.delete(myUrl as Uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  Future <void> editcarData(String model, String color, String plate_NO) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    http.put(Uri.parse('https://safelyy.store/api/CarUpdate'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          "model": "$model",
          "color": "$color",
          "plate_NO": "$plate_NO"
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future <void> addcarData(String model, String color, String plate_NO,
      [String? trim]) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    http.post(Uri.parse('https://safelyy.store/api/CarStore'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          "model": "$model",
          "color": "$color",
          "plate_NO": "$plate_NO"
        }
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  Future <void> deletecarData(String model, String color, String plate_NO,
      [String? trim]) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    http.delete(Uri.parse('https://safelyy.store/api/carDelete'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          "model": "$model",
          "color": "$color",
          "plate_NO": "$plate_NO"
        }
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  Future <void> addcontactData(String first_name, String phone_number,
      String relationship, [String? trim]) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'access_token';
    final value = prefs.get(key);
    http.post(Uri.parse('https://safelyy.store/api/store_emergency_contact'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          "first_name": "$first_name",
          "phone_number": "$phone_number",
          "relationship": "$relationship"
        }
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  void deletecontactData(String phone_number, String? trim2,
      [String? trim]) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    //String myUrl = "$serverUrl/carDelete/";
    http.delete(Uri.parse('https://safelyy.store/api/emergency-contact-delete'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          //   "first_name": "$first_name",
          "phone_number": "$phone_number",
          // "relationship" : "$relationship"
        }).
    then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


// Future <void> editcontactData(String first_name , String phone_number,String relationship) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'access_token';
  //   final value = prefs.get(key) ?? 0;
  //
  //   http.put(Uri.parse('https://safelyy.store/api/store_emergency_contact'),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $value'
  //       },
  //       body: {
  //         "first_name": "$first_name",
  //         "phone_number": "$phone_number",
  //         "relationship": "$relationship"
  //       }).then((response) {
  //     print('Response status : ${response.statusCode}');
  //     print('Response body : ${response.body}');
  //   });
  // }


  // Future<void> addEmergencyContact_screenData(
  //     String Contact_1,
  //     String Contact_2,
  //     String Contact_3,
  //     String RelationshipContact_1,
  //     String RelationshipContact_2,
  //     String RelationshipContact_3,
  //     [String? trim]) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'access_token';
  //   final value = prefs.get(key);
  //   http.post(Uri.parse('https://safelyy.store/api/'), headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $value'
  //   }, body: {
  //     "Contact_1": "$Contact_1",
  //     "Contact_2": "$Contact_2",
  //     "Contact_3": "$Contact_3",
  //     "RelationshipContact_1": "$RelationshipContact_1",
  //     "RelationshipContact_2": "$RelationshipContact_2",
  //     "RelationshipContact_3": "$RelationshipContact_3"
  //   }).then((response) {
  //     print('Response status : ${response.statusCode}');
  //     print('Response body : ${response.body}');
  //     });
  //   }


  Future <void> UpdatePersonalData(String model, String color, String plate_NO,
      [String? trim]) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key);
    http.post(Uri.parse('https://safelyy.store/api/CarStore'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $value'
        },
        body: {
          "model": "$model",
          "color": "$color",
          "plate_NO": "$plate_NO"
        }
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}