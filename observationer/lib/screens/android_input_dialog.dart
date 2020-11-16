import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:observationer/model/input_dialog.dart';
import 'package:observationer/model/observation.dart';

/// A material design style dialog for Android.
class AndroidInputDialog implements InputDialog {
  AndroidInputDialog(
      {@required this.onPressPositive(Observation ob),
      @required this.onPressNegative,
      @required this.pos});

  @override
  Function onPressPositive;

  @override
  Function onPressNegative;

  String title;
  String desc;
  Position pos;

  Widget buildDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Lägg till ny observation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                width: 150,
                image: AssetImage('assets/images/Placeholder.png'),
              ),
              Text('Bifoga ny bild'),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Titel...'),
            onChanged: (val) {
              title = val;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            maxLength: 250,
            decoration: InputDecoration(labelText: 'Anteckningar...'),
            onChanged: (val) {
              desc = val;
            },
          ),
          Center(
            child: SizedBox(
              height: 8.0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  textStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                child: new Text('Avbryt'),
                onPressed: () {
                  onPressNegative();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 32.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  textStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                child: new Text('Lägg till'),
                onPressed: () {
                  onPressPositive(Observation(
                      subject: title,
                      body: desc,
                      latitude: pos.latitude,
                      longitude: pos.longitude));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
