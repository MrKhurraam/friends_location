import 'package:flutter/material.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_provider.dart';
import '../widgets/common_dialogs.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            emailField(bloc),
            passwordField(bloc),
            submitButton(bloc),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/SignupScreen');
                },
                child: Text(
                  "Don't Have an Account ? Sign up",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordField(UserBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Password",
              labelText: "Password",
              errorText: "${snapshot.error ?? ''}",
            ),
          );
        });
  }

  Widget emailField(UserBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Email",
              labelText: "Email",
              errorText: "${snapshot.error ?? ''}",
            ),
          );
        });
  }

  Widget submitButton(UserBloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return ElevatedButton(
              onPressed: snapshot.hasData
                  ? () async {
                      try {
                        ShowDialog.showLoadingDialog(
                            title: "Logging wait", context: context);
                        final res = await bloc.signIn();
                        if (res == 1) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigator.pushNamed(context, '/GetLocation');
                        }
                      } catch (e) {
                        // CLosing showLoadingDialog
                        Navigator.pop(context);

                        ShowDialog.showErrorDialog(
                            title: "Login Error",
                            description: "$e",
                            context: context);
                      }
                    }
                  : null,
              child: Text("Submit"));
        });
  }
}
