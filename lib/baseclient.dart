import 'package:http/http.dart' as http;

const String baseUrl = 'https://localhost:7173/api/v1';

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api,dynamic object) async{
    var url = Uri.parse(baseUrl + api);
    var _header = null;
    var response = await client.get(url, headers: _header);
    if(response.statusCode == 200) {
      return response.body;
    } else {

    }
  }
  Future<dynamic> post(String api) async{}
  Future<dynamic> put(String api) async{}
  Future<dynamic> delete(String api) async{}
}