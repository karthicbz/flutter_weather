import 'package:flutter/material.dart';
import 'package:weather_app/services/get_weather_details.dart';

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
      setState((){
        forecastData = forecastDetails;
        // print(forecastData['list']);
      });
    }catch(e){
      throw 'something went wrong $e';
    }

  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> forecastLocation = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    getForecastDetails(forecastLocation['location']);
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
          child: forecastData != null?ListView.builder(itemCount: forecastData['list'].length, itemBuilder: (BuildContext context, int index){
            return Card(
              color: Colors.deepOrange[50],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("${forecastData['list'][index]['dt_txt'].toString().split(' ')[1].replaceFirst(":00", "")}, "
                        "${forecastData['list'][index]['dt_txt'].toString().split(' ')[0]}, "
                        "${forecastData['list'][index]['weather'][0]['description']}"),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(image: NetworkImage("https://openweathermap.org/img/wn/${forecastData['list'][index]['weather'][0]['icon']}@2x.png"),
                        width: 50,
                        height: 50,),
                        Column(
                          children: [
                            Text("Temp", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecastData['list'][index]['main']['temp'].toString()}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Feels like", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecastData['list'][index]['main']['feels_like'].toString()}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Temp min", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecastData['list'][index]['main']['temp_min'].toString()}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Temp max", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecastData['list'][index]['main']['temp_max'].toString()}", style: TextStyle(color: Colors.deepOrange),),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Humidity", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 8,),
                            Text("${forecastData['list'][index]['main']['humidity'].toString()}%", style: TextStyle(color: Colors.deepOrange),),
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
