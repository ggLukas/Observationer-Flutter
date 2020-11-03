import 'package:flutter/material.dart';
import 'package:observationer/model/observation.dart';

/// The view that displays specific/detailed data for a singular Observation.
class OneObservationPage extends StatefulWidget {
  OneObservationPage(this.obs);

  final Observation obs;

  @override
  _OneObservationPageState createState() => _OneObservationPageState(obs);
}

class _OneObservationPageState extends State<OneObservationPage> {
  _OneObservationPageState(this.obs);

  Observation obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(obs.subject),
        ),
        body: Column(children: [
          Text("Anteckningar: " +
              obs.body +
              "\n" +
              "Created: " +
              obs.created +
              "\n" +
              "Position: " +
              obs.longitude.toString() +
              ", " +
              obs.latitude.toString()),

          Image.network(
            //Displays first image
            obs.imageUrl[0],
            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
              return observationWithoutImage();
            },
          ),

        ]));
  }

  Widget observationWithoutImage(){
    return Container(
      child: Image(
        image: AssetImage('assets/images/Placeholder.png'),
      ),
    );
  }
}
