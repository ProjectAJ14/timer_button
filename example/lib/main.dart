import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timer_button/timer_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Button Demo'),
      ),
      body: Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TimerButton(
                  label: "Elevated: Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.ElevatedButton,
                  color: Colors.green,
                ),
                TimerButton(
                  label: "Outlined: Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.OutlinedButton,
                  disabledColor: Colors.deepOrange,
                  color: Colors.green,
                  activeTextStyle: const TextStyle(color: Colors.yellow),
                  disabledTextStyle: const TextStyle(color: Colors.pink),
                ),
                TimerButton(
                  label: "Text: Try Again",
                  timeOutInSeconds: -5,
                  onPressed: () {
                    log("Time for some action!");
                  },
                  timeUpFlag: true,
                  buttonType: ButtonType.TextButton,
                  disabledColor: Colors.deepOrange,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
