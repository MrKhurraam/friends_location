import 'package:flutter/cupertino.dart';
import 'package:live_friends_location/src/bloc/user_bloc.dart';

class UserProvider extends InheritedWidget {
  final bloc = UserBloc();

  UserProvider({required Widget child}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static UserBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>()!.bloc;
  }
}
