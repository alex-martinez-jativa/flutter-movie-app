import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/widgets/feedback_message.dart';

void main() {
  testWidgets('FeedbackMessage Widget has text and color',
      (WidgetTester tester) async {
    var widget = FeedbackMessage(text: 'error text', color: 'warning');
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

    expect(find.text('error text'), findsOneWidget);
    expect(((tester.firstWidget(find.text('error text')) as Text).style).color,
        Colors.red);
  });

  testWidgets('FeedbackMessage Widget text is blue',
      (WidgetTester tester) async {
    var widget = FeedbackMessage(text: 'info text', color: 'info');

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: widget,
    )));

    expect(find.text('info text'), findsOneWidget);
    expect(((tester.firstWidget(find.text('info text')) as Text).style).color,
        Colors.blue);
  });
  testWidgets('FeedbackMessage Widget text is green',
      (WidgetTester tester) async {
    var widget = FeedbackMessage(text: 'info text', color: 'success');

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: widget,
    )));

    expect(find.text('info text'), findsOneWidget);
    expect(((tester.firstWidget(find.text('info text')) as Text).style).color,
        Colors.green);
  });
}
