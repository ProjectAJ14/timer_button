import 'package:flutter/material.dart';
import 'package:timer_button_fork/timer_button_fork.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Timer Button Fork Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
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
                  label: "Elevated: Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.ElevatedButton,
                  color: Colors.green,
                ),
                new TimerButton(
                  label: "Outlined: Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.OutlinedButton,
                  disabledColor: Colors.deepOrange,
                  color: Colors.green,
                  activeTextStyle: TextStyle(color: Colors.yellow),
                  disabledTextStyle: TextStyle(color: Colors.pink),
                ),
                new TimerButton(
                  label: "Text: Try Again",
                  timeOutInSeconds: 5,
                  onPressed: () {
                    print("Time for some action!");
                  },
                  buttonType: ButtonType.TextButton,
                  disabledColor: Colors.deepOrange,
                  color: Colors.green,
                ),
                TimerButton.builder(
                  onPressed: () {
                    print("Hey, a custom button is clicked!");
                  },
                  timeOutInSeconds: 5,
                  timeBuilder: (BuildContext context, int sec) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      color: sec > 0 ? Colors.red : Colors.green,
                      child: Text(
                        sec > 0 ? "Custom Wait for $sec seconds" : "Click Me",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
