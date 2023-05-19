import 'dart:async';
import 'package:flutter/material.dart';

/// [ButtonType] enum to define the type of the button.
enum ButtonType { ElevatedButton, TextButton, OutlinedButton, Custom }

const int aSec = 1;
const String _secPostFix = 's';
const String labelSplitter = " |  ";

/// Type definition for TimerButton builder.
typedef TimerButtonBuilder = Widget Function(BuildContext context, int seconds);

/// A custom TimerButton that starts a timer when pressed and shows the remaining time.
class TimerButton extends StatefulWidget {
  /// Label of the button.
  final String label;

  /// Postfix for seconds.
  final String secPostFix;

  /// Timeout in seconds after which the button is enabled.
  final int timeOutInSeconds;

  /// Callback when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base color.
  final Color color;

  /// The color to use for the button's background/border when the button is disabled.
  final Color disabledColor;

  /// Text style for active state.
  final TextStyle? activeTextStyle;

  /// Text style for disabled state.
  final TextStyle disabledTextStyle;

  /// Type of the button.
  final ButtonType buttonType;

  /// Boolean value to decide if timer should reset on button pressed.
  final bool resetTimerOnPressed;

  /// The builder for the custom button.
  final TimerButtonBuilder? timeBuilder;

  /// Constructor for the TimerButton
  const TimerButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.secPostFix = _secPostFix,
    this.color = Colors.blue,
    this.resetTimerOnPressed = true,
    this.disabledColor = Colors.grey,
    this.buttonType = ButtonType.ElevatedButton,
    this.activeTextStyle,
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  }) : timeBuilder = null, super(key: key);

  /// Constructor for the TimerButton using builder.
  TimerButton.builder({
    Key? key,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.resetTimerOnPressed = true,
    required this.timeBuilder,
  })  : label = '',
        secPostFix = _secPostFix,
        color = Colors.blue,
        disabledColor = Colors.grey,
        buttonType = ButtonType.Custom,
        activeTextStyle = null,
        disabledTextStyle = const TextStyle(color: Colors.black45),
        super(key: key);

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

/// Private class for the TimerButton State.
class _TimerButtonState extends State<TimerButton> {
  /// Boolean flag to determine if time is up.
  bool timeUpFlag = false;

  /// Counter for time.
  int timeCounter = 0;

  /// Timer instance.
  late Timer _timer;

  /// Function that initiates state.
  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    _startTimer();
  }

  /// Starts the timer.
  void _startTimer() {
    _timer = Timer(const Duration(seconds: aSec), () {
      if (!mounted) return;
      setState(() {
        timeCounter--;
        if (timeCounter > 0) {
          _startTimer();
        } else {
          timeUpFlag = true;
        }
      });
    });
  }

  /// Builds the child widget for the button.
  Widget _buildChild() {
    TextStyle? activeTextStyle;
    if (widget.activeTextStyle == null) {
      if (widget.buttonType == ButtonType.OutlinedButton ||
          widget.buttonType == ButtonType.TextButton) {
        activeTextStyle = TextStyle(color: widget.color);
      } else {
        activeTextStyle = TextStyle(color: Colors.white);
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
        widget.label + labelSplitter + '$timeCounter${widget.secPostFix}',
        style: widget.disabledTextStyle,
      ),
    );
  }

  /// Callback for onPressed.
  void _onPressed() {
    if (timeUpFlag) {
      setState(() {
        timeUpFlag = false;
      });
      timeCounter = widget.timeOutInSeconds;
      widget.onPressed();
      if (widget.resetTimerOnPressed) {
        _startTimer();
      }
    }
  }

  /// Dispose the state and cancel the timer.
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Build method for the widget.
  @override
  Widget build(BuildContext context) {
    if (widget.buttonType == ButtonType.Custom && widget.timeBuilder != null) {
      return GestureDetector(
        onTap: _onPressed,
        child: widget.timeBuilder!.call(context, timeCounter),
      );
    } else {
      switch (widget.buttonType) {
        case ButtonType.ElevatedButton:
          return ElevatedButton(
            onPressed: _onPressed,
            child: _buildChild(),
            style: ElevatedButton.styleFrom(
              backgroundColor: timeUpFlag ? widget.color : widget.disabledColor,
            ),
          );
        case ButtonType.TextButton:
          return TextButton(
            onPressed: _onPressed,
            child: _buildChild(),
            style: TextButton.styleFrom(
              backgroundColor: timeUpFlag ? widget.color : widget.disabledColor,
            ),
          );
        case ButtonType.OutlinedButton:
          return OutlinedButton(
            onPressed: _onPressed,
            child: _buildChild(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: timeUpFlag ? widget.color : widget.disabledColor,
              ),
            ),
          );
        case ButtonType.Custom:
        default:
          return Container();
      }
    }
  }
}
