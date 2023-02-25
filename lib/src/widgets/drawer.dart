// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class AppDrawer extends StatelessWidget {
//   AppDrawer({super.key, required this.dataController});
//
//   final DataController dataController;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         width: 220,
//         child: Drawer(
//           child: ListView(
//             children: [
//               Container(
//                 decoration:
//                     BoxDecoration(color: Theme.of(context).primaryColor),
//                 height: 80,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       'User : ${dataController.userProfileData['userName']}',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     FittedBox(
//                       child: Text(
//                         'Join Date :${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(dataController.userProfileData['joinDate']))} ',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.person),
//                 title: const Text('Your Product'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: const Text('LogOut'),
//                 onTap: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
