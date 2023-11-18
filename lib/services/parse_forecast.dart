class ParseForecast{
  String? time;
  String? date;
  String? desc;
  String? image;
  String? temp;
  String? feelsLike;
  String? tempMin;
  String? tempMax;
  String? humidity;
  dynamic? forecastData;

  ParseForecast(this.forecastData);

  void addWeatherDetails(index){
    time = forecastData['list'][index]['dt_txt'].toString().split(' ')[1].replaceFirst(":00", "");
    date = forecastData['list'][index]['dt_txt'].toString().split(' ')[0];
    desc = forecastData['list'][index]['weather'][0]['description'];
    image = forecastData['list'][index]['weather'][0]['icon'];
    temp = forecastData['list'][index]['main']['temp'].toString();
    feelsLike = forecastData['list'][index]['main']['feels_like'].toString();
    tempMin = forecastData['list'][index]['main']['temp_min'].toString();
    tempMax = forecastData['list'][index]['main']['temp_max'].toString();
    humidity = forecastData['list'][index]['main']['humidity'].toString();
  }
}