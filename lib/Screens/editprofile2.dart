// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:udemy_flutter/Screens/homescreen.dart';
// import 'package:udemy_flutter/auth_services.dart';
// import 'package:udemy_flutter/globals.dart';
// import 'package:http/http.dart' as http;
//
//
// class EditProfileUI extends StatefulWidget {
//   static const String screenRoute = 'EditProfileUI';
//   const EditProfileUI({Key? key}) : super(key: key);
//
//
//   @override
//   _EditProfileUIState createState() => _EditProfileUIState();
// }
//
// class _EditProfileUIState extends State<EditProfileUI> {
//   final auth = AuthServices();
//
//   String _firstname = '';
//   String _lastname = '';
//   // String _email = '';
//   // String _password = '';
//   String _healthproblems = '';
//   String _address = '';
//
//
//   Future <void> updatedataPressed(String firstname,String lastname,String healthproblems,String address) async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'access_token';
//     final value = prefs.get(key) ?? 0;
//
//     if (_firstname.isNotEmpty && _lastname.isNotEmpty
//         && _healthproblems.isNotEmpty && _address.isNotEmpty) {
//       http.put(Uri.parse('http://127.0.0.1:8000/api/store_emergency_contact'),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $value'
//           },
//           body: {
//             "first_name": "$_firstname",
//             "lastname": "$_lastname",
//             "health problems": "$_healthproblems",
//             "address": "$_address"
//           }).then((response) {
//         print('Response status : ${response.statusCode}');
//         print('Response body : ${response.body}');
//       });
//     }
//
//
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: const Color(0xFF2c363b),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2c363b),
//           title: const Text('Profile'),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Color(0xFFffae46),
//             ), onPressed: () {
//             Navigator.pushNamed(context, HomeScreen.screenRoute);
//           },
//           ),
//         ),
//
//         body: Container(
//           padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
//           child: GestureDetector(
//             onTap: () {
//               FocusScope.of(context).unfocus();
//             },
//             child: ListView(
//               children: [
//                 Center(
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: 130,
//                         height: 130,
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 4, color: Colors.white),
//                             boxShadow: [
//                               BoxShadow(
//                                   spreadRadius: 2,
//                                   blurRadius: 10,
//                                   color: Colors.black.withOpacity(0.1)
//                               )
//                             ],
//                             shape: BoxShape.circle,
//                             image: const DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(
//                                     ''
//                                 )
//                             )
//                         ),
//                       ),
//                       Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                   width: 4,
//                                   color: Colors.white
//                               ),
//                               color: Colors.amber,
//                             ),
//                             child: const Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                             ),
//                           )
//                       )
//                     ],
//                   ),
//                 ),
//
//
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: const InputDecoration(
//                           hintText: 'Enter your First Name',
//                         ),
//                         onChanged: (value) {
//                           _firstname = value;
//                         },
//                       ),
//
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: const InputDecoration(
//                           hintText: 'Enter your Last Name',
//                         ),
//                         onChanged: (value) {
//                           _lastname = value;
//                         },
//                       ),
//
//
//
//
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter your Health Problems',
//                         ),
//                         onChanged: (value) {
//                           _healthproblems = value;
//                         },
//                       ),
//
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter your Address',
//                         ),
//                         onChanged: (value) {
//                           _address = value;
//                         },
//                       ),
//
//                       const SizedBox(
//                         height: 30,
//                       ),
//
//
//                       ElevatedButton(
//                         onPressed:() async {
//                           updatedataPressed(firstname, lastname, healthproblems, address);
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFffae46),
//                             padding: const EdgeInsets.symmetric(horizontal: 50),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
//                         ),
//                         child: const Text("Save", style: TextStyle(
//                             fontSize: 15,
//                             letterSpacing: 2,
//                             color: Colors.white
//                         )),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }