import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentWeather{
  String? location;
  String unit = 'metric';
  String apiKey = '228a3f9fe276acdf8c030f707cddc96f';

  CurrentWeather(this.location);

  Future<Map> getCurrentWeather() async{
    try{
      var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${location}&units=${unit}&APPID=${apiKey}'));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }catch(e){
      // print('something went wrong $e');
      throw 'Something went wrong $e';
    }
  }
}