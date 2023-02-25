import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_friends_location/src/bloc/user_provider.dart';
import '../../firebase_options.dart';
import '../resources/application_state.dart';
import '../widgets/authentication.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = UserProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/codelab.png',
              height: 300,
            ),
            const SizedBox(height: 8),
            const IconAndDetail(Icons.calendar_today, 'October 30'),
            const IconAndDetail(Icons.location_city, 'San Francisco'),
            // Add from here

            StreamBuilder(
              stream: userBloc.loggedIn,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                print("userBloc.logged snapshot = ${snapshot.data}");
                if (!snapshot.hasData) {
                  return Text("Logged in varible empty");
                }

                return AuthFunc(
                  loggedIn: snapshot.data!,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  },
                );
              },
            ),

            const SizedBox(height: 8),
            const Divider(
              height: 8,
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: Colors.grey,
            ),
            const Header("What we'll be doing"),
            const Paragraph(
              'Join us for a day full of Firebase Workshops and Pizza!',
            ),
          ],
        ),
      ),
    );
  }
}
