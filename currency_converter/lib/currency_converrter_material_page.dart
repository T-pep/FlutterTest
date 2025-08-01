import 'dart:math';

import 'package:flutter/material.dart';

class CurrencyConverrterMaterialPage extends StatelessWidget {
  const CurrencyConverrterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.5,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Plese enter the amount in USD',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('hi you stupid idiot clicked the button');
                },
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(10),
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 10),
                  ),
                ),
                child: Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
