import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/weather_forecast_item.dart';
import 'package:weather_app/Additional_Info_Item.dart';
import 'package:weather_app/smal_class.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State {
  late Future weather;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
    debugPrint('initState');
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWetherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'Something bad happend';
      }

      return data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String test = 'moin';

  @override
  Widget build(BuildContext context) {
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
                  // getCurrencyWeather();
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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final double currentTemp = data['list'][0]['main']['temp'];
          final String currentSky = data['list'][0]['weather'][0]['main'];
          final int currentPressure = data['list'][0]['main']['pressure'];
          final double currentWindSpeed = data['list'][0]['wind']['speed'];
          final int currentHumidity = data['list'][0]['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${toDegreeCel(currentTemp).toString()}°C',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(iconWeather(currentSky), size: 70),
                              Text(
                                currentSky,
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
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                /* SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 10; i++)
                        HourlyForecastItem(
                          time: data['list'][i]['dt'].toString(),
                          icon: iconWeather(
                            data['list'][i]['weather'][0]['main'].toString(),
                          ),
                          temperature:
                              '${toDegreeCel(
                                data['list'][i]['main']['temp'],
                              )} °C',
                        ),
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(
                        data['list'][index + 1]['dt_txt'],
                      );
                      return HourlyForecastItem(
                        time: DateFormat.Hm().format(time),
                        temperature:
                            '${toDegreeCel(
                              data['list'][index + 1]['main']['temp'],
                            )} °C',
                        icon: iconWeather(
                          data['list'][index + 1]['weather'][0]['main']
                              .toString(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
