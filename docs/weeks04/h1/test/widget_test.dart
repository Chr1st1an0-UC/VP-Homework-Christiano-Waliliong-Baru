import 'package:flutter_test/flutter_test.dart';
import 'package:h1/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('TCG Vault'), findsOneWidget);
  });
}
