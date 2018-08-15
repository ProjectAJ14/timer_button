# Timer Button
A new Flutter package for timer button.

![timer_button](https://cdn-images-1.medium.com/max/640/1*NhgmN1C4ltcQA-o34SYbIQ.gif)


A Button which will be enabled after specified time.

## Usage
Set ButtonType for Button. There are 3 Type of button :
 - RaisedButton ```buttonType: ButtonType.RaisedButton``` (defalut)
 - FlatButton ```buttonType: ButtonType.FlatButton```
 - OutlineButton ```buttonType: ButtonType.OutlineButton```
 


Set text/lable  ``` label: "Try Again" ```

Set timeout in secounds ``` timeOutInSeconds: 20 ```

Set color ```color: Colors.deepPurple```

Set disabled color ``` disabledColor: Colors.red ```

## Example

``` 
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
                  label: "Send OTP Again",
                  timeOutInSeconds: 20,
                  onPressed: () {},
                  disabledColor: Colors.red,
                  color: Colors.deepPurple,
                  disabledTextStyle: new TextStyle(fontSize: 20.0),
                  activeTextStyle: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                new TimerButton(
                  label: "Try Again",
                  timeOutInSeconds: 10,
                  onPressed: () {},
                  buttonType: ButtonType.OutlineButton,
                ),
                new TimerButton(
                  label: "CLOSE",
                  timeOutInSeconds: 5,
                  onPressed: () {},
                  buttonType: ButtonType.FlatButton,
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

```








