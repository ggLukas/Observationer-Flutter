import 'package:flutter/material.dart';

import 'map_view.dart';
import 'observations_page.dart';

/// The starting page of the application.
class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Background_observations.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: StartingPageBody(),
        ),
      ),
    );
  }
}

class StartingPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Spacer(),//widget som fyller upp eventuell plats som är kvar på skärmen

        const SizedBox(height:150, width: 150,
          child: Image(image: AssetImage("assets/images/obs_icon.png")),
        ),

        Text('Observationer',
          style: TextStyle(
            color: Color(0xFF6ACEF0),
            fontSize: 36.0,
            fontWeight: FontWeight.bold
          ),
        ),

        Spacer(),

        Padding(padding: EdgeInsets.symmetric(vertical: 15),
          child: Text('Välkommen till Observationer',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
        ),

        new ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 63, vertical: 15),
                textStyle: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MapView()));
            },
            child: new Text('Till kartvyn'),
        ),

        Padding(padding: EdgeInsets.symmetric(vertical: 15),
          child: Text('Eller',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.bold
            )
          ),
        ),

        new ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              textStyle: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.of(context).push(
              MaterialPageRoute<void>(
                  builder: (context) => ObservationsPage()));
            },
            child: new Text('Utforska observationer'),
              ),

        Spacer(),

      ]
    );
  }
}
