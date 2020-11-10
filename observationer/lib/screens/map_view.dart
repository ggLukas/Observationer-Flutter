import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observationer/model/input_dialog.dart';
import 'package:observationer/screens/android_input_dialog.dart';
import 'package:observationer/screens/ios_input_dialog.dart';
import 'package:geolocator/geolocator.dart';

/// The map view. Shows current position and allows user to create new observations.
class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //TODO: This should be loaded in from current GPS position.
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  InputDialog _inputDialog;
  Position _position;
  String _lat = '0.0';
  String _long = '0.0';
  GoogleMap _googleMap;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _cameraPosition;

  void getCurrentPosition() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        this._position = position;
        this._lat = position.latitude.toStringAsFixed(2);
        this._long = position.longitude.toStringAsFixed(2);
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        );
      });
      print(position.latitude.toString() + " " + position.longitude.toString());
    });
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    print("animating loc");
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  Widget currentLocationView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
        margin: EdgeInsets.only(bottom: 30.0),
        child: locationAvailable(),
      ),
    );
  }

  /// If location is not available this func will return appropriate UI for that.
  Widget locationAvailable() {
    return _position == null
        ? Center(
            child: Text(
              'Location unavailable',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lat:$_lat',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                'Long:$_long',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          );
  }

  @override
  void initState() {
    super.initState();

    Platform.isIOS
        ? _inputDialog = iOSInputDialog()
        : _inputDialog = AndroidInputDialog();
    getCurrentPosition();
    _googleMap = GoogleMap(
      initialCameraPosition:
          _cameraPosition == null ? _kGooglePlex : _cameraPosition,
      zoomControlsEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'icon',
              child: Image(
                color: Colors.white,
                image: AssetImage('assets/images/obs_icon.png'),
                width: 20.0,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Karta'),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.hybrid,
              liteModeEnabled: false,
              initialCameraPosition:
                  _cameraPosition == null ? _kGooglePlex : _cameraPosition,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                goToCurrentLocation();
              },
            ),
            currentLocationView(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return _inputDialog.buildDialog(context);
                });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
