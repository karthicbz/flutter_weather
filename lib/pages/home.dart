import 'package:flutter/material.dart';
import 'package:weather_app/services/get_weather_details.dart';
import 'package:weather_app/pages/forecast.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // CurrentWeather weather = CurrentWeather("chennai");
  TextEditingController myController = TextEditingController();
  Map fetchedWeatherDetails = {
    'imageId':'',
    'temp':'',
    'feelsLike':'',
    'tempMin':'',
    'tempMax':'',
    'humidity':'',
    'desc':'',
  };

  Future<void> setWeatherData() async{
    try {
      if(myController.text == ''){myController = TextEditingController(text: "chennai");}
      CurrentWeather weather = CurrentWeather(myController.text);
      var data = await weather.getCurrentWeather();
      setState(() {
        fetchedWeatherDetails["imageId"] = data["weather"][0]["icon"];
        fetchedWeatherDetails["temp"] = data["main"]["temp"].toString();
        fetchedWeatherDetails["feelsLike"] =
            data["main"]["feels_like"].toString();
        fetchedWeatherDetails["tempMin"] = data["main"]["temp_min"].toString();
        fetchedWeatherDetails["tempMax"] = data["main"]["temp_max"].toString();
        fetchedWeatherDetails["humidity"] = data["main"]["humidity"].toString();
        fetchedWeatherDetails["desc"] = data["weather"][0]["description"].toString();
      });
    }catch(e){
      print('error happened $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWeatherData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('WeatherApp'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          // SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              controller: myController,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange, width: 1)
                ),
                hintText: 'Location',
                focusColor: Colors.deepOrangeAccent,
                fillColor: Colors.white,
              ),
            ),
          ),
          TextButton(onPressed: ()async{
            setWeatherData();
          }, child: Text('Search', style: TextStyle(fontSize: 17),),
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade100),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 16, horizontal: 160)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )
              )
          ),),
          fetchedWeatherDetails['imageId'] != ''?Image(image: NetworkImage('https://openweathermap.org/img/wn/${fetchedWeatherDetails['imageId']}@2x.png')):Container(),
          Text("${fetchedWeatherDetails["desc"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          SizedBox(height: 10,),
          Text(fetchedWeatherDetails["temp"] != ''?"${fetchedWeatherDetails["temp"]} \u00b0C":'',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Feels Like", style: TextStyle(fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("${fetchedWeatherDetails["feelsLike"]} \u00b0C", style: TextStyle(fontSize: 22)),
                ],
              ),
              Column(
                children: [
                  Text("Temp min", style: TextStyle(fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("${fetchedWeatherDetails["tempMin"]} \u00b0C", style: TextStyle(fontSize: 22)),
                ],
              ),
              Column(
                children: [
                  Text("Temp max", style: TextStyle(fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("${fetchedWeatherDetails["tempMax"]} \u00b0C", style: TextStyle(fontSize: 22)),
                ],
              ), Column(
                children: [
                  Text("Humidity", style: TextStyle(fontSize: 16),),
                  SizedBox(height: 10,),
                  Text("${fetchedWeatherDetails["humidity"]}", style: TextStyle(fontSize: 22)),
                ],
              )
            ],
          ),
          SizedBox(height: 30,),
          TextButton.icon(
              onPressed: (){
                Navigator.pushNamed(context, "/forecast", arguments: {'location':myController.text.toString()});
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Get Forecast for ${myController.text}")),
        ],
      ),
    );
  }
}
