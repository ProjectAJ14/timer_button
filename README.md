
# Timer Button for Flutter

[![Build](https://img.shields.io/badge/build-4.0.0-brightgreen)](https://github.com/chetanxpatil/timer_button_fork)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Timer Button is a Flutter package that provides an interactive, self-disabling button which re-enables after a specified timeout. With our major 4.0.0 release, we have introduced `TimerButton.builder` for more customizability.

![ezgif-1-f263ff5ef4](https://github.com/chetanxpatil/timer_button_fork/assets/71105582/8d7e4805-ca27-4d6c-859e-3ffe3c7d183c)

## Getting Started

1. Open `pubspec.yaml` in your project.
2. Add `timer_button_fork` dependency and replace `[version]` with the latest version:

```yaml
dependencies:
  flutter:
    sdk: flutter
  timer_button_fork: ^[version]
```
3. Install it by running command: `flutter pub get`

## Importing the Package

```dart
import 'package:timer_button_fork/timer_button_fork.dart';
```

## Usage

Choose from three types of buttons:

- ElevatedButton: `buttonType: ButtonType.ElevatedButton`
- TextButton: `buttonType: ButtonType.TextButton`
- OutlinedButton: `buttonType: ButtonType.OutlinedButton`

Specify the label text: `label: "Try Again"`

Set the timeout duration in seconds: `timeOutInSeconds: 20`

Define button colors: `color: Colors.deepPurple`, `disabledColor: Colors.red`

Now, you can also customize the appearance and behavior of the button during the timeout period using `TimerButton.builder`.

## Example

Traditional use:
```
TimerButton(
  label: "Send OTP Again",
  timeOutInSeconds: 20,
  onPressed: () {},
  disabledColor: Colors.red,
  color: Colors.deepPurple,
  disabledTextStyle: TextStyle(fontSize: 20.0),
  activeTextStyle: TextStyle(fontSize: 20.0, color: Colors.white),
)
```

With `TimerButton.builder`:

```
TimerButton.builder(
  timeOutInSeconds: 20,
  timeBuilder: (BuildContext context, int seconds) {
    return Text("$seconds seconds");
  },
  onPressed: () {
    print('Button Pressed!');
  },
)
```

For issues, bugs, and feature requests, visit our [GitHub repository](https://github.com/chetanxpatil/timer_button_fork).

## Contributing

We'd love to have your contributions! Here's how you can help:

- Propose new features or enhancements
- Report bugs
- Fix open issues
- Participate in discussions and help in decision making
- Improve documentation. We can't stress the importance of this enough!

Submit your contributions as pull requests on [our GitHub](https://github.com/chetanxpatil/timer_button_fork).

---

Please replace `4.0.0` with your actual package version number.
