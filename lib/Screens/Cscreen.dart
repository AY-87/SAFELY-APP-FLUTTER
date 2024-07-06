// import 'package:flutter/material.dart';
// import 'homescreen.dart';
//
// calling emergency contact
//
// class Cscreen extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage(
//             'assets/images/popo.jpeg',
//           ),
//           fit: BoxFit.cover,
//         )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(32),
//                   child: Container(
//                     width: 227,
//                     height: 48,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         elevation: 20,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HomeScreen(),
//                           ),
//                         );
//                       },
//                       child: Text('Okay',
//                           style: TextStyle(
//                             fontSize: 30,
//                             color: Colors.white,
//                           )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
