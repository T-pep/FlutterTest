import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/weather_forecast_item.dart';
import 'package:weather_app/Additional_Info_Item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State createState() => _WeatherScreenState();
}

String test = 'moin';
double temp = 0;
bool isLoading = true;

class _WeatherScreenState extends State {
  @override
  void initState() {
    super.initState();
    getCurrencyWeather();
  }

  Future getCurrencyWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWetherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      setState(() {
        temp = data['list'][0]['main']['temp'];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('The Error is: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(test);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather App'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  test = 'it works';
                  getCurrencyWeather();
                });
              },
              icon: Icon(
                Icons.autorenew,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color.fromARGB(255, 48, 43, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                Text(
                                  '$temp K',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.cloud, size: 70),
                                Text(
                                  'Rain',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForecastItem(
                          time: '9:00',
                          icon: Icons.cloud,
                          temperature: '90°C',
                        ),
                        HourlyForecastItem(
                          time: '10:00',
                          icon: Icons.cloud,
                          temperature: '10°C',
                        ),
                        HourlyForecastItem(
                          time: '11:00',
                          icon: Icons.cloud,
                          temperature: '50°C',
                        ),
                        HourlyForecastItem(
                          time: '12:00',
                          icon: Icons.cloud,
                          temperature: '99°C',
                        ),
                        HourlyForecastItem(
                          time: '13:00',
                          icon: Icons.cloud,
                          temperature: 'viel°C',
                        ),
                        HourlyForecastItem(
                          time: '14:00',
                          icon: Icons.cloud,
                          temperature: '∞°C',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '91',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '7.5',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '1000',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
