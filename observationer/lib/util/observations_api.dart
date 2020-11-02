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
    var data = await http
        .get('https://saabstudent2020.azurewebsites.net/observation/');

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      //Not sure if this is the best way
      for (var o in jsonData) {
        Observation obs = Observation(
            o['id'],
            o['subject'],
            o['body'],
            o['created'],
            o['position']['longitude'],
            o['position']['latitude']);
        if (!observations.contains(obs)) {
          observations.add(obs);
        }
      }
      return observations;
    } else {
      throw Exception('Failed to load observations');
    }
  }
}
