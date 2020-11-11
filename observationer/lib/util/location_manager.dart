import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  Position _position;

  /// If location services become inactive, users last known position will be saved in this var.
  Position _lastKnownPosition;

  double _lat = 0.0;
  double _long = 0.0;

  Function _onPositionUpdateReceived;
  Function _onLocationServicesDisabled;
  Function _onLocationServicesEnabled;

  /// Gets continuous stream of position updates.
  void getPositionUpdates(
      void onPositionUpdateReceived(double lat, double long)) async {
    this._onPositionUpdateReceived = onPositionUpdateReceived;

    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    Geolocator.getPositionStream().listen((Position position) {
      this._position = position;
      this._lat = position.latitude;
      this._long = position.longitude;

      _onPositionUpdateReceived(_lat, _long);

      print(position.latitude.toString() + " " + position.longitude.toString());
    }).onError((Object error) {
      if (error is LocationServiceDisabledException) {
        _lastKnownPosition = _position;
        _position = null;
        _onLocationServicesDisabled();
        _waitForLocationServices();
      }
    });
  }

  /// Gets the users current location ONCE.
  Future<Position> getCurrentLocation() async {
    _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .catchError((error, stackTrace) {
      if (error is LocationServiceDisabledException) {
        _lastKnownPosition = _position;
        _position = null;
        _onLocationServicesDisabled();
        _waitForLocationServices();
      }
    });
    return _position;
  }

  /// Code to be executed when the location services has been disabled.
  void onLocationServicesDisabled(void onLocationServicesDisabled()) =>
      _onLocationServicesDisabled = onLocationServicesDisabled;

  /// Code to be executed when the location services has been enabled.
  void onLocationServicesEnabled(void onLocationServicesEnabled()) =>
      _onLocationServicesEnabled = onLocationServicesEnabled;

  Position getPosition() => _position;

  /// If location services were disabled then we wait for them to be active once again.
  Future<void> _waitForLocationServices() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      _onLocationServicesEnabled();
    }
  }
}