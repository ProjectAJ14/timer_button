library timer_button;

import 'dart:async';

import 'package:flutter/material.dart';

/// Type definition for TimerButton builder.
///
typedef TimerButtonBuilder = Widget Function(BuildContext context, int seconds);

enum ButtonType {
  elevatedButton,
  textButton,
  outlinedButton,
  custom,
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

  final TimerButtonBuilder? builder;

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
    this.buttonType = ButtonType.elevatedButton,
    this.activeTextStyle,
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  })  : builder = null,
        super(key: key);

  /// Builder factory for creating a themed [TimerButton].
  ///
  const TimerButton.builder({
    Key? key,
    required this.builder,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.resetTimerOnPressed = true,
    this.timeUpFlag = false,
  })  : buttonType = ButtonType.custom,
        activeTextStyle = null,
        disabledColor = Colors.grey,
        color = Colors.blue,
        label = '',
        secPostFix = _secPostFix,
        disabledTextStyle = const TextStyle(color: Colors.black45),
        super(key: key);

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool _timeUpFlag = false;
  int _timeCounter = 0;
  late Timer _timer;

  String get _timerText => '$_timeCounter${widget.secPostFix}';

  @override
  void initState() {
    super.initState();
    _timeCounter = widget.timeOutInSeconds;
    _timeUpFlag = widget.timeUpFlag;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _updateTime() {
    if (_timeUpFlag) {
      return;
    }
    _timer = Timer(const Duration(seconds: aSec), () async {
      if (!mounted) return;
      _timeCounter--;
      _updateState();
      if (_timeCounter >= 0) {
        _updateTime();
      } else {
        _timeUpFlag = true;
      }
    });
  }

  void _onPressed() {
    _timeUpFlag = false;
    _timeCounter = widget.timeOutInSeconds;
    _updateState();
    widget.onPressed();
    // reset the timer when the button is pressed
    if (widget.resetTimerOnPressed) {
      _updateTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return GestureDetector(
        onTap: _timeUpFlag ? _onPressed : null,
        child: widget.builder!(
          context,
          _timeCounter,
        ),
      );
    }
    final color = _timeUpFlag ? widget.color : widget.disabledColor;
    final child = TimerButtonChild(
      timeUpFlag: _timeUpFlag,
      label: widget.label,
      timerText: _timerText,
      activeTextStyle: widget.activeTextStyle,
      disabledTextStyle: widget.disabledTextStyle,
      color: color,
      buttonType: widget.buttonType,
    );
    switch (widget.buttonType) {
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed: _timeUpFlag ? _onPressed : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: color,
          ),
          child: child,
        );
      case ButtonType.textButton:
        return TextButton(
          onPressed: _timeUpFlag ? _onPressed : null,
          style: TextButton.styleFrom(
            backgroundColor: color,
          ),
          child: child,
        );
      case ButtonType.outlinedButton:
        return OutlinedButton(
          onPressed: _timeUpFlag ? _onPressed : null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: color,
            ),
          ),
          child: child,
        );
      default:
        return Container();
    }
  }
}

class TimerButtonChild extends StatelessWidget {
  final bool timeUpFlag;
  final String label;
  final String timerText;
  final TextStyle? activeTextStyle;
  final TextStyle disabledTextStyle;
  final Color color;
  final ButtonType buttonType;

  const TimerButtonChild({
    Key? key,
    required this.timeUpFlag,
    required this.label,
    required this.timerText,
    this.activeTextStyle,
    required this.disabledTextStyle,
    required this.color,
    required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = timeUpFlag
        ? activeTextStyle ??
            (buttonType == ButtonType.outlinedButton
                ? TextStyle(color: color)
                : const TextStyle(color: Colors.white))
        : disabledTextStyle;
    final text = timeUpFlag ? label : '$label$labelSplitter$timerText';

    return Text(
      text,
      style: textStyle,
    );
  }
}
