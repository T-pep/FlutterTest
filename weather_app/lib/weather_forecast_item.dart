import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Card(
        elevation: 6,

        child: Column(
          children: [
            SizedBox(height: 5),
            Text(
              time,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Icon(
              icon,
              size: 50,
            ),
            SizedBox(height: 8),
            Text(
              temperature,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
