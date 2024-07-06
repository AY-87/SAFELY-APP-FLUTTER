// import 'package:flutter/material.dart';
//
// class Zscreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       home:
//       Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/ooo.jfif',),
//               fit: BoxFit.cover,
//             )),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0,),
//                   color: Colors.black,
//                 ),
//                 child:
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('There is an accident',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 25
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Text('Press show for details',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14
//                           ),
//                         ),
//
//
//                         SizedBox(
//                           height: 20.0,
//                         ),
//
//                         Row (children: [
//
//                           Container(
//                             width:300 ,
//                             height:40,
//
//                             child:ElevatedButton(onPressed: ()
//                             {
//                             },
//                               style:ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//
//                               ),
//                               child: Text('Show',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//
//                           ),
//                         ],
//
//                         ),
//
//                       ],
//
//
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//       ),
//     );
//   }
// }