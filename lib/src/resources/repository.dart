import 'location_controller.dart';

class Repository {
  final _locationController = GetLocation();

  getPermission() async {
    var position = await _locationController.getPermission();
    return position;
  }

  getCurrentLocation() async {
    await _locationController.getCurrentLocation();
  }
}
