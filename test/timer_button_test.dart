import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer_button/timer_button.dart';

void main() {
  group('TimerButton', () {
    testWidgets('should enable button when timer is done', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimerButton(
              label: 'Start',
              onPressed: () {},
              timeOutInSeconds: 1,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isTrue);
    });
  });
}
//TODO(Ajay) : Add more tests