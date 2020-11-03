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

      for(int i = jsonData.length - 1; i >= 0; i--){
        Observation obs = Observation(
            jsonData[i]['id'],
            jsonData[i]['subject'],
            jsonData[i]['body'],
            jsonData[i]['created'],
            jsonData[i]['position']['longitude'],
            jsonData[i]['position']['latitude']);
        observations.add(obs);
      }
      return observations;
    } else {
      throw Exception('Failed to load observations');
    }
  }
}
