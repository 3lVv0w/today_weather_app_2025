import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:today_weather_2025/models/weather_data.dart';
import 'package:today_weather_2025/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio dio = Dio();
  WeatherData? weatherData;
  ForecastData? forecastData;


  @override
  void initState() {
    super.initState();
    fetchData();
    fetchForecastData();
  }

  void fetchData() async {
    try {
      final response = await dio.get('https://api.openweathermap.org/data/2.5/weather?APPID=d6af4baa8ac12c9e9ba1aa2946170b51&lat=13.7563&lon=100.5018');
      // You can parse the response data here using your WeatherData model
      // For example:
      weatherData = WeatherData.fromJson(response.data);
      setState(() {});
    } catch (e, stackTrace) {
      debugPrint('Error fetching data: $e');
      debugPrint(stackTrace.toString());
    }
  }

  // TODO :implement forecast data fetch
  void fetchForecastData() async {
    try {
      final response = await dio.get('https://api.openweathermap.org/data/2.5/forecast?APPID=d6af4baa8ac12c9e9ba1aa2946170b51&lat=13.7563&lon=100.5018');
      forecastData = ForecastData.fromJson(response.data);
      // You can parse the response data here using your ForecastData model
      setState(() {});
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      debugPrint('Error fetching forecast data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weatherData?.name ?? '', style: TextStyle(fontSize: 20, color: Colors.white),),
                Text(weatherData?.weather?.first.main ?? '', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                Text("${weatherData?.main?.temp ?? ''}°F", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),
                Image.network('https://openweathermap.org/img/w/${weatherData?.weather?.first.icon}.png', width: 50, height: 50,),
                Text(weatherData?.dt != null ? DateTime.fromMillisecondsSinceEpoch((weatherData!.dt! as int) * 1000).toString() : '', style: TextStyle(fontSize: 16,color: Colors.white),),
                IconButton(onPressed: () {}, icon: Icon(Icons.refresh, color: Colors.white,))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              child: Row( // TODO: Replace with Row
                  children: forecastData?.list?.map((weatherData) {
                    final iconUrl = 'https://openweathermap.org/img/w/${weatherData.weather!.first.icon}.png';
                    return Container(
                      width: 150,
                      height: double.infinity,
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.only(right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(formatHour((weatherData.dt! as int)), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8.0,),
                          Image.network(iconUrl , width: 50, height: 50,),
                          SizedBox(height: 8.0,),
                          Text(formatTemperature((weatherData.main!.temp! as double)), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    );
                  }).toList() ?? [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
