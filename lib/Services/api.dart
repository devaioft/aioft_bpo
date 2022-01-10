import 'package:aioft_bpo/Models/driver_model.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final baseUrl = 'http://3.108.3.83/api';
  Future<List<Drivers>> fetchDriver(String endsPoint) async {
    var fullUrl = baseUrl + endsPoint;

    var response = await http.get(Uri.parse(fullUrl));

    return driversFromJson(response.body);
  }

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
