import 'package:aioft_bpo/Models/driver_model.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final baseUrl = 'http://3.108.3.83/api';

  Future<List<Drivers>> fetchDriver(String endsPoint) async {
    var fullUrl = baseUrl + endsPoint;

    var response = await http.get(Uri.parse(fullUrl));

    return driversFromJson(response.body);
  }
}
