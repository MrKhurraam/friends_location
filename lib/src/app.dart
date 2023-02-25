import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_friends_location/src/resources/application_state.dart';
import 'package:live_friends_location/src/screens/login_screen.dart';
import 'package:live_friends_location/src/screens/show_location.dart';
import 'package:live_friends_location/src/screens/signup.dart';

import 'bloc/bloc_providers/location_provider.dart';
import 'bloc/user_provider.dart';
import 'widgets/widgets.dart';
import 'screens/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LocationProvider(
      child: UserProvider(
        child: MaterialApp(
          //Start adding here
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(builder: ((context) {
                final appState = InitializeFirebase(context);
                return HomePage();
              }));
            } else if (settings.name == '/SignupScreen') {
              return MaterialPageRoute(
                builder: (context) {
                  final locationBLoc = LocationProvider.of(context);
                  // locationBLoc.fetchPermission();
                  // locationBLoc.getCurrentLocation();
                  return SignUp();
                },
              );
            } else if (settings.name == '/LoginScreen') {
              return MaterialPageRoute(
                builder: (context) {
                  final locationBLoc = LocationProvider.of(context);
                  // locationBLoc.getCurrentLocation();
                  // locationBLoc.fetchPermission();
                  return LoginScreen();
                },
              );
            } else if (settings.name == '/GetLocation') {
              return MaterialPageRoute(
                builder: (context) {
                  return ShowLocation();
                },
              );
            }
          },
          // end adding here
          title: 'Firebase Meetup',
          theme: ThemeData(
            buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  highlightColor: Colors.deepPurple,
                ),
            primarySwatch: Colors.deepPurple,
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
      ),
    );
  }
}
