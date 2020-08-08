library timer_button;

import 'dart:async';

import 'package:flutter/material.dart';

enum ButtonType { RaisedButton, FlatButton, OutlineButton }

const int aSec = 1;

const String secPostFix = 's';
const String labelSplitter = " |  ";

class TimerButton extends StatefulWidget {
  /// Create a TimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  ///label
  final String label;

  ///[timeOutInSeconds] after which the button is enabled
  final int timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base colors
  final Color color;

  /// The color to use for this button's text when the button is disabled.
  final Color disabledColor;

  /// activeTextStyle
  final TextStyle activeTextStyle;

  ///disabledTextStyle
  final TextStyle disabledTextStyle;

  ///buttonType
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
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool timeUpFlag = false;
  int timeCounter = 0;

  String get _timerText => '$timeCounter$secPostFix';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0)
        _timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  Widget _buildChild() {
    return Container(
      child: timeUpFlag
          ? Text(
              widget.label,
              style: (widget.buttonType == ButtonType.OutlineButton)
                  ? widget.activeTextStyle.copyWith(color: widget.color)
                  : widget.activeTextStyle,
            )
          : Text(
              widget.label + labelSplitter + _timerText,
              style: widget.disabledTextStyle,
            ),
    );
  }

  _onPressed() {
    if (timeUpFlag) {
      if (widget.onPressed != null) widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.RaisedButton:
        return RaisedButton(
          disabledColor: widget.disabledColor,
          color: widget.color,
          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
      case ButtonType.FlatButton:
        return FlatButton(
          color: widget.color,
          disabledColor: widget.disabledColor,
          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
      case ButtonType.OutlineButton:
        return OutlineButton(
          borderSide: BorderSide(
            color: widget.color,
          ),
          disabledBorderColor: widget.disabledColor,
          onPressed: _onPressed,
          child: _buildChild(),
        );
        break;
    }

    return Container();
  }
}
