import 'package:flutter/material.dart';
import 'package:timer_button/timer_button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Timer Button Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Timer Button Demo'),
      ),
      body: new Material(
        child: new Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new TimerButton(
                  label: "Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.RaisedButton,
                  disabledColor: Colors.red,
                ),
                new TimerButton(
                  label: "Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.FlatButton,
                  disabledColor: Colors.red,
                ),
                new TimerButton(
                  label: "Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.OutlineButton,
                  disabledColor: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
