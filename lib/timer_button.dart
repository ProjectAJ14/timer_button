library timer_button;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum ButtonType { RaisedButton, FlatButton, OutlineButton }

class TimerButton extends StatefulWidget {
  /// Create a TimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  final String label;

  final int timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base colors
  final Color color;

  /// The color to use for this button's text when the button is disabled.
  final Color disabledColor;

  final TextStyle activeTextStyle;

  final TextStyle disabledTextStyle;

  final ButtonType buttonType;

  const TimerButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.timeOutInSeconds,
    this.color = Colors.blue,
    this.disabledColor,
    this.buttonType = ButtonType.RaisedButton,
    this.activeTextStyle = const TextStyle(color: Colors.white),
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  })  : assert(label != null),
        assert(activeTextStyle != null),
        assert(disabledTextStyle != null),
        super(key: key);

  @override
  _TimerButtonState createState() => new _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool timeUpFlag = false;
  String timeText = "0s";
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    timeText = "${timeCounter}s";
    timerUpdate();
  }

  timerUpdate() {
    new Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
        timeText = "${timeCounter}s";
      });
      if (timeCounter != 0)
        timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  Widget getChild() {
    return new Container(
      child: timeUpFlag
          ? new Text(
              "    " + widget.label + "    ",
              style: (widget.buttonType == ButtonType.OutlineButton)
                  ? widget.activeTextStyle.copyWith(color: widget.color)
                  : widget.activeTextStyle,
            )
          : new Text(widget.label + " |  " + timeText, style: widget.disabledTextStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.RaisedButton:
        return new RaisedButton(
            disabledColor: widget.disabledColor,
            color: widget.color,
            onPressed: timeUpFlag
                ? () {
                    widget.onPressed();
                  }
                : null,
            child: getChild());
        break;
      case ButtonType.FlatButton:
        return new FlatButton(
            color: widget.color,
            disabledColor: widget.disabledColor,
            onPressed: timeUpFlag
                ? () {
                    widget.onPressed();
                  }
                : null,
            child: getChild());
        break;
      case ButtonType.OutlineButton:
        return new OutlineButton(
            borderSide: new BorderSide(
              color: widget.color,
            ),
            disabledBorderColor: widget.disabledColor,
            onPressed: timeUpFlag
                ? () {
                    widget.onPressed();
                  }
                : null,
            child: getChild());
        break;
    }

    return new Container();
  }
}
