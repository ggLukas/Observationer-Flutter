import 'package:flutter/material.dart';

import 'map_view.dart';
import 'observations_page.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 150),
          Hero(
            tag: 'icon',
            child: Image(
              image: AssetImage('assets/images/obs_icon.png'),
              width: 80.0,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Observationer',
            style: TextStyle(
                color: Color(0xFF6ACEF0),
                fontSize: 26.0,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 250), //This is probably a bad way
          new ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 15),
              textStyle: TextStyle(
                fontSize: 20.0,
              ),
            ),
            child: new Text('Till kartvyn'),
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapView()))
            },
          ),
          const SizedBox(height: 50),
          new ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 17),
              textStyle: TextStyle(
                fontSize: 14.0,
              ),
            ),
            child: new Text('Utforska observationer'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (context) => ObservationsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
