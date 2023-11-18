import 'package:flutter/material.dart';
import 'package:weather_app/services/get_weather_details.dart';
import 'package:weather_app/services/parse_forecast.dart';

class forecast extends StatefulWidget {
  const forecast({super.key});

  @override
  State<forecast> createState() => _forecastState();
}

class _forecastState extends State<forecast> {

  dynamic forecastData;

  Future<void> getForecastDetails(String? location) async{
      try {
        CurrentWeather weather = CurrentWeather(location);
        dynamic forecastDetails = await weather.getForecast();
        if(mounted) {
          setState(() {
            forecastData = forecastDetails;
            // print(forecastData['list']);
          });
        }
      } catch (e) {
        throw 'something went wrong $e';
      }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> forecastLocation = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    getForecastDetails(forecastLocation['location']);
    ParseForecast forecast = ParseForecast(forecastData);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Forecast"),
            Text("${forecastLocation['location']}", style: TextStyle(fontSize: 16),),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [Expanded(
          child: forecast.forecastData != null?ListView.builder(itemCount: forecast.forecastData['list'].length, itemBuilder: (BuildContext context, int index){
            forecast.addWeatherDetails(index);
            return Card(
              color: Colors.deepOrange[50],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("${forecast.time}, "
                        "${forecast.date}, "
                        "${forecast.desc}"),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(image: NetworkImage("https://openweathermap.org/img/wn/${forecast.image}@2x.png"),
                        width: 50,
                        height: 50,),
                        Column(
                          children: [
                            Text("Temp", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecast.temp}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Feels like", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecast.feelsLike}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Temp min", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecast.tempMin}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Temp max", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecast.tempMax}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Humidity", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecast.humidity}%", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }):Container(),
        )],
      ),
    );
  }
}
