import 'package:flutter/cupertino.dart';

import '../location_bloc.dart';

class LocationProvider extends InheritedWidget {
  final bloc = LocationBLoc();

  LocationProvider({required Widget child}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static LocationBLoc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocationProvider>()!.bloc;
  }
}
