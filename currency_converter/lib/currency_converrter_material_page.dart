import 'package:flutter/material.dart';

class CurrencyConverrterMaterialPage extends StatefulWidget {
  const CurrencyConverrterMaterialPage({super.key});
  @override
  State createState() => _CurrencyConverrterMaterialPageState();
}

class _CurrencyConverrterMaterialPageState extends State {
  String? result = '';
  final TextEditingController textEditingCon = TextEditingController();

  @override
  void dispose() {
    textEditingCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuilt');
    debugPrint(result.toString());
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black, width: 2.5),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Text('Converter', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                result.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: textEditingCon,
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
                  setState(() {
                    if (textEditingCon.text != '' &&
                        result.toString().length <= 11) {
                      double calculation =
                          double.parse(textEditingCon.text) * 0.81;
                      result = calculation.toStringAsFixed(2) + '€';
                    }
                    if (result.toString().length > 11) {
                      result = 'Val to High';
                    }
                    if (textEditingCon.text == '') {
                      result = 'Val null';
                    }
                    textEditingCon.text = '';
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5, //only for a elevator buttons
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                  ),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),

                  minimumSize: const Size(double.infinity, 10),
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
