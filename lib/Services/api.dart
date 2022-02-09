import 'dart:convert';

import 'package:aioft_bpo/Models/fleet_driver_model.dart';
import 'package:aioft_bpo/Models/user_model.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final baseUrl = 'https://taxyee.aioft.com/api/flutterapi';

  Future<Users> fetchUsers(String endsPoint) async {
    var fullUrl = baseUrl + endsPoint;
    var response = await http.get(
      Uri.parse(fullUrl),
      headers: {'Accept': "Application/json"},
    );
    final jsonresponse = json.decode(response.body);
    // print(jsonresponse[0]);
    return usersFromJson(jsonresponse);
  }

//Fetch Fleet Driver data when click on fleet data
  Future<FleetDrivers> fetchFleetDrivers(String endsPoint, String id) async {
    var fullUrl = baseUrl + endsPoint + id;
    var response = await http.get(
      Uri.parse(fullUrl),
      headers: {'Accept': "Application/json"},
    );
    // final jsonresponse = json.decode(response.body);
    // print(jsonresponse[0]);
    // print(response.body);
    return fleetDriversFromJson(response.body);
  }

//updatUserData
  Future<void> updateDataIntoDataBase(data, apiEndspoint, id) async {
    var _response = await http.post(
      Uri.parse(baseUrl + apiEndspoint + id),
      body: data,
      headers: {'Accept': "Application/json"},
    );
    if (_response.statusCode == 200) {
      print(_response.body);
    }
    print('called');
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
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIwMDM0NiwiaXNzIjoiaHR0cHM6XC9cL2Nsb3VkcGhvbmUudGF0YXRlbGVzZXJ2aWNlcy5jb21cL3Rva2VuXC9nZW5lcmF0ZSIsImlhdCI6MTY0NDM4MTg2MSwiZXhwIjoxOTQ0MzgxODYxLCJuYmYiOjE2NDQzODE4NjEsImp0aSI6IlV5UzBtZnJvb3dMVEZqSU0ifQ.SRBzfT6RWpAquCcxs6JmCAjAtdof0X6fipC8eHWZ3Hk',
        'Accept': "Application/json"
      },
    );

    print(response.body);
  }
}
