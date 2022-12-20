library timer_button;

import 'dart:async';

import 'package:flutter/material.dart';

enum ButtonType {
  ElevatedButton,
  TextButton,
  OutlinedButton,
}

const int aSec = 1;

const String _secPostFix = 's';
const String labelSplitter = " |  ";

/// A button that starts a timer and disables itself until the timer is done.

class TimerButton extends StatefulWidget {
  /// Create a TimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  ///label
  final String label;

  ///secPostFix
  final String secPostFix;

  ///[timeOutInSeconds] after which the button is enabled
  final int timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base colors
  final Color color;

  /// The color to use for this button's background/border when the button is disabled.
  final Color disabledColor;

  /// activeTextStyle
  final TextStyle? activeTextStyle;

  ///disabledTextStyle
  final TextStyle disabledTextStyle;

  ///buttonType
  final ButtonType buttonType;

  ///If resetTimerOnPressed is true reset the
  ///timer when the button is pressed : default to true
  final bool resetTimerOnPressed;

  ///
  final bool timeUpFlag;

  const TimerButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.secPostFix = _secPostFix,
    this.color = Colors.blue,
    this.resetTimerOnPressed = true,
    this.timeUpFlag = false,
    this.disabledColor = Colors.grey,
    this.buttonType = ButtonType.ElevatedButton,
    this.activeTextStyle,
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  }) : super(key: key);

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool timeUpFlag = false;
  int timeCounter = 0;

  String get _timerText => '$timeCounter${widget.secPostFix}';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    timeUpFlag = widget.timeUpFlag;
    _timerUpdate();
  }

  _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  _timerUpdate() {
    if (timeUpFlag) {
      return;
    }
    // To avoid negative values
    if (timeCounter < 0) {
      timeCounter = -1 * timeCounter;
    }
    Timer(const Duration(seconds: aSec), () async {
      timeCounter--;
      _updateState();
      if (timeCounter != 0) {
        _timerUpdate();
      } else {
        timeUpFlag = true;
      }
    });
  }

  Widget _buildChild() {
    TextStyle? activeTextStyle;
    if (widget.activeTextStyle == null) {
      if (widget.buttonType == ButtonType.OutlinedButton) {
        activeTextStyle = TextStyle(color: widget.color);
      } else {
        activeTextStyle = const TextStyle(color: Colors.white);
      }
    } else {
      activeTextStyle = widget.activeTextStyle;
    }
    return Container(
      child: timeUpFlag
          ? Text(
              widget.label,
              style: activeTextStyle,
            )
          : Text(
              widget.label + labelSplitter + _timerText,
              style: widget.disabledTextStyle,
            ),
    );
  }

  _onPressed() {
    if (timeUpFlag) {
      timeUpFlag = false;
      _updateState();
      timeCounter = widget.timeOutInSeconds;
      widget.onPressed();
      // reset the timer when the button is pressed
      if (widget.resetTimerOnPressed) {
        _timerUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = timeUpFlag ? widget.color : widget.disabledColor;
    switch (widget.buttonType) {
      case ButtonType.ElevatedButton:
        return ElevatedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: color,
          ),
          child: _buildChild(),
        );
      case ButtonType.TextButton:
        return TextButton(
          onPressed: _onPressed,
          style: TextButton.styleFrom(
            backgroundColor: color,
          ),
          child: _buildChild(),
        );
      case ButtonType.OutlinedButton:
        return OutlinedButton(
          onPressed: _onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: color,
            ),
          ),
          child: _buildChild(),
        );
      default:
        return Container();
    }
  }
}
