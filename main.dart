import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredictionView extends StatefulWidget {
  @override
  _GenderPredictionViewState createState() => _GenderPredictionViewState();
}

class _GenderPredictionViewState extends State<GenderPredictionView> {
  String _name = '';
  String _gender = '';
  Color _color = Colors.transparent;

  Future<void> _predictGender(String name) async {
    final response =
        await http.get('https://api.genderize.io/?name=$name' as Uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
        _color = _gender == 'male' ? Colors.blue : Colors.pink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter a name:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _predictGender(_name);
              },
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            Text(
              'Gender Prediction: $_gender',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              color: _color,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: GenderPredictionView()));
}
