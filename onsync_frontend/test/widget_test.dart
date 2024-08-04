import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onsync_app/main.dart';
import 'package:onsync_app/api_service.dart'; // Import your ApiService class

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create an instance of ApiService with the required argument(s)
    final apiService = ApiService(
        'your_argument'); // Replace 'your_argument' with the actual argument

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(apiService: apiService));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
