import 'dart:convert';
import '../model/observation.dart';
import 'package:http/http.dart' as http;

/// This class is responsible for communication with the observations API.
class ObservationsAPI {
  final List<Observation> observations = [];

  /// Fetches all observations from the database.
  ///
  /// Returns a list of Observations sometime in the future.
  Future<List<Observation>> fetchObservations() async {
    //Get all observations
    var data = await http
        .get('https://saabstudent2020.azurewebsites.net/observation/');

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      for (int i = jsonData.length - 1; i >= 0; i--) {
        Observation obs;

        //Get the image of observation
        var imageData = await http.get(
            'https://saabstudent2020.azurewebsites.net/observation/' +
                jsonData[i]['id'].toString() +
                '/attachment');

        if (imageData.statusCode == 200) {
          var jsonImageData = json.decode(imageData.body);
          List<String> imageUrl = [];

          //If the observation has image(s)
          if (!jsonImageData.isEmpty) {
            for (int y = 0; y < jsonImageData.length; y++) {
              imageUrl.add(
                  'https://saabstudent2020.azurewebsites.net/observation/' +
                      jsonData[i]['id'].toString() +
                      '/attachment/' +
                      jsonImageData[y]['id'].toString() +
                      '/data');
            }
          } else {
            //Temporary fix(probably). Right now, in one_observation_page we take the imageUrl[0], so cant be empty
            imageUrl.add('');
          }

          obs = Observation(
              jsonData[i]['id'],
              jsonData[i]['subject'],
              jsonData[i]['body'],
              jsonData[i]['created'],
              jsonData[i]['position']['longitude'],
              jsonData[i]['position']['latitude'],
              imageUrl);
        } else {
          throw Exception('Failed to load attachment page for an observation');
        }

        observations.add(obs);
      }

      return observations;
    } else {
      throw Exception('Failed to load observations');
    }
  }
}
