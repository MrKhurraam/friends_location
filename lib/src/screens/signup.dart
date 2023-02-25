import 'dart:io';
import 'package:flutter/material.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_provider.dart';
import '../widgets/common_dialogs.dart';
import '../widgets/user_image_picker.dart';

class SignUp extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            nameField(bloc),
            emailField(bloc),
            Flexible(fit: FlexFit.loose, child: UserImagePicker(bloc: bloc)),
            passwordField(bloc),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget nameField(UserBloc bloc) {
    return TextField(
      onChanged: bloc.changeName,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Enter Name",
        labelText: "Name",
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
              hintText: "Enter Password",
              labelText: "Password",
              errorText: '${snapshot.error ?? ''}',
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
              hintText: "Enter email",
              labelText: "email",
              errorText: '${snapshot.error ?? ''}',
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
                            title: "Signing In", context: context);
                        final res = await bloc.signUp();
                        if (res == 1) {
                          // CLosing showLoadingDialog
                          Navigator.pop(context);

                          // poping to move back to login screen
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        // CLosing showLoadingDialog
                        Navigator.pop(context);

                        ShowDialog.showErrorDialog(
                            title: "Sign in Error",
                            description: "$e",
                            context: context);
                      }
                    }
                  : null,
              child: Text("Submit"));
        });
  }
}
