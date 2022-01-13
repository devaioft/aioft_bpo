import 'package:aioft_bpo/Models/fleet_model.dart';
import 'package:http/http.dart' as http;
import 'package:aioft_bpo/Models/provider_model.dart';

class CallApi {
  final baseUrl = 'https://taxyee.aioft.com/api/provider';
  Future<List<Providers>> fetchProviders(String endsPoint) async {
    var fullUrl = baseUrl + endsPoint;
    var token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE4OCwiaXNzIjoiaHR0cHM6Ly90YXh5ZWUuYWlvZnQuY29tL2FwaS9wcm92aWRlci9vYXV0aC90b2tlbiIsImlhdCI6MTY0MTgxNTYwNCwiZXhwIjoxNjQyMTc1NjA0LCJuYmYiOjE2NDE4MTU2MDQsImp0aSI6InZ4a01UbTNxYUNwak1QVW0ifQ.lgK_Y--td68kdaVlqoO0IOOUVAG_uIqe_gbEkv6iPyA';
    var response = await http.get(
      Uri.parse(fullUrl),
      headers: {'Authorization': 'Bearer $token', 'Accept': "Application/json"},
    );
    return providersFromJson(response.body);
  }

Future<List<FleetUser>> fetchFleetUsers(String endsPoint) async {
    var fullUrl = baseUrl + endsPoint;
    var token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE4OCwiaXNzIjoiaHR0cHM6Ly90YXh5ZWUuYWlvZnQuY29tL2FwaS9wcm92aWRlci9vYXV0aC90b2tlbiIsImlhdCI6MTY0MTgxNTYwNCwiZXhwIjoxNjQyMTc1NjA0LCJuYmYiOjE2NDE4MTU2MDQsImp0aSI6InZ4a01UbTNxYUNwak1QVW0ifQ.lgK_Y--td68kdaVlqoO0IOOUVAG_uIqe_gbEkv6iPyA';
    var response = await http.get(
      Uri.parse(fullUrl),
      headers: {'Authorization': 'Bearer $token', 'Accept': "Application/json"},
    );
    return fleetUserFromJson(response.body);
  }

//Tatatelecome Api
  postDataIntoTataTelecomeApi(data, apiEndPoints) async {
    final tataBaseURl =
        "https://api-smartflo.tatateleservices.com/v1" + apiEndPoints;

    var response = await http.post(
      Uri.parse(tataBaseURl),
      body: data,
      headers: {
        'Authorization':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIwMDM0NiwiaXNzIjoiaHR0cHM6XC9cL2Nsb3VkcGhvbmUudGF0YXRlbGVzZXJ2aWNlcy5jb21cL3Rva2VuXC9nZW5lcmF0ZSIsImlhdCI6MTY0MDYwMDY2NCwiZXhwIjoxOTQwNjAwNjY0LCJuYmYiOjE2NDA2MDA2NjQsImp0aSI6ImhMYU5TRkd5anZvbVdLOWMifQ.dmpL0q-Ut4BB6N8vLQtZ0nkl97H5kItk15Dznq88auo',
        'Accept': "Application/json"
      },
    );

    print(response.body);
  }
}
