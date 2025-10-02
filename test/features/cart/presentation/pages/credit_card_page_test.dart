import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruits_market/features/cart/presentation/pages/credit_card_page.dart';
import 'package:fruits_market/core/utils/sized_config.dart';

void main() {
  testWidgets('CreditCardPage form validation and loading/success states', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            SizeConfig().init(context);
            return const CreditCardPage(total: 100);
          },
        ),
      ),
    );

    // Verify initial state: form is shown, no loading or success message
    expect(find.text('Add Your Card'), findsOneWidget);
    expect(find.text('Save Card'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Payment Successful'), findsNothing);
    expect(find.text('Your Order is Booked.'), findsNothing);

    // Tap Save Card without filling form (should not show loading)
    await tester.tap(find.text('Save Card'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Fill valid data in form fields
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), '4242 4242 4242 4242');
    await tester.enterText(find.byType(TextFormField).at(2), '12/25');
    await tester.enterText(find.byType(TextFormField).at(3), '123');

    // Tap Save Card with valid form (should show loading)
    await tester.tap(find.text('Save Card'));
    await tester.pump();

    // Loading indicator should appear
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for 2 seconds to simulate loading completion
    await tester.pump(const Duration(seconds: 2));

    // Success message should appear
    expect(find.text('Payment Successful'), findsOneWidget);
    expect(find.text('Your Order is Booked.'), findsOneWidget);

    // CircularProgressIndicator should disappear
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
