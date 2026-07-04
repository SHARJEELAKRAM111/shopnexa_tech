import 'package:flutter_test/flutter_test.dart';
import 'package:tons_hons/app/app.dart';

void main() {
  testWidgets('Smoke test - Verify homepage renders brand name', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ShopNexaApp());

    // Verify that the company logo/name is displayed in our app widgets
    expect(find.text('ShopNexa Technologies'), findsWidgets);
  });
}
