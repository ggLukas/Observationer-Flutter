import 'dart:convert';
import '../model/observation.dart';
import 'package:http/http.dart' as http;

/// This class is responsible for communication with the observations API.
class ObservationsAPI {
  final List<Observation> observations = [];
  final List<String> imageUrl = [];

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
        //If the observation has image(s)
        Observation obs = Observation(
            jsonData[i]['id'],
            jsonData[i]['subject'],
            jsonData[i]['body'],
            jsonData[i]['created'],
            jsonData[i]['position']['longitude'],
            jsonData[i]['position']['latitude'],
            ['']);

        observations.add(obs);
      }
      return observations;
    } else {
      throw Exception('Failed to load observations');
    }
  }

  Future<List<String>> fetchObservationImages(Observation observation) async {
    Observation obs = observation;

    var imageData = await http.get(
        'https://saabstudent2020.azurewebsites.net/observation/' +
            obs.id.toString() +
            '/attachment');
    if (imageData.statusCode == 200) {
      var jsonImageData = json.decode(imageData.body);

      if (!jsonImageData.isEmpty) {
        for (int y = 0; y < jsonImageData.length; y++) {
          imageUrl.add(
              'https://saabstudent2020.azurewebsites.net/observation/' +
                  obs.id.toString() +
                  '/attachment/' +
                  jsonImageData[y]['id'].toString() +
                  '/data');
        }
      } else {
        //Temporary fix(probably). Right now, in one_observation_page we take the imageUrl[0], so cant be empty
        imageUrl.add('');
      }
    } else {
      throw Exception('Failed to load observation image page');
    }

    return imageUrl;
  }
}
