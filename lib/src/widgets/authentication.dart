import 'package:flutter/material.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: StyledButton(
              onPressed: () {
                loggedIn
                    ? signOut()
                    : Navigator.of(context).pushNamed('/LoginScreen');
              },
              child: loggedIn
                  ? const Text('Logout')
                  : const Text('CLick to Login')),
        ),
        Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/GetLocation');
                  },
                  child: const Text('Profile')),
            ))
      ],
    );
  }
}
