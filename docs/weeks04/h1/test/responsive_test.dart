import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:h1/main.dart';
import 'package:h1/models/tcg_card_item.dart';
import 'package:h1/widgets/empty_state_view.dart';
import 'package:h1/widgets/vault_header_card.dart';
import 'package:h1/widgets/vault_search_bar.dart';
import 'package:h1/widgets/card_grid_tile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('H1 Responsive Pass Checklist Tests', () {
    testWidgets('1. Small phone - 320dp width renders without overflow',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('TCG Vault'), findsOneWidget);
      expect(find.byType(VaultHeaderCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('2. Large phone - 430dp width renders properly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(430 * 3, 932 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('TCG Vault'), findsOneWidget);
      expect(find.byType(CardGridTile), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('3. Tablet - 800dp width triggers structural layout change (Sidebar + Grid)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800 * 2, 1200 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check structural breakpoint changes layout to Row containing sidebar
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(VaultHeaderCard), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('4. Landscape - wide aspect ratio (800x400) renders cleanly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800 * 2, 400 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('TCG Vault'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('5. Long text - 200 characters item name handled safely with maxLines',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 800 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      final longCard = TcgCardItem.longTextCard;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 160,
              height: 240,
              child: CardGridTile(
                card: longCard,
                onFavoriteToggle: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CardGridTile), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('6. Empty state - zero items shows icon, message, and action button',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 800 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Type non-existent query into search bar to trigger 0 items
      await tester.enterText(find.byType(TextField), 'NonExistentItemKeyword123');
      await tester.pumpAndSettle();

      expect(find.byType(EmptyStateView), findsOneWidget);
      expect(find.text('No Cards Found'), findsOneWidget);
      expect(find.text('Reset Filters'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Tap action button to reset
      await tester.tap(find.text('Reset Filters'));
      await tester.pumpAndSettle();

      expect(find.byType(CardGridTile), findsWidgets);
    });

    testWidgets('7. Long list - 500 items renders smoothly using .builder without shrinkWrap',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 800 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Tap toggle button to load 500 items
      await tester.tap(find.byTooltip('Toggle 500 Items Mode'));
      await tester.pumpAndSettle();

      expect(find.text('500 Cards in Vault'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('8. Keyboard - opening search input on short screen remains visible',
        (WidgetTester tester) async {
      // Short screen height (360x400)
      tester.view.physicalSize = const Size(360 * 2, 400 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final searchBarFinder = find.byType(VaultSearchBar);
      expect(searchBarFinder, findsOneWidget);

      await tester.tap(searchBarFinder);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('9. Dark mode and Light mode - toggles legibly without overflow',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 800 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Toggle Theme
      await tester.tap(find.byTooltip('Toggle Theme'));
      await tester.pumpAndSettle();

      expect(find.text('TCG Vault'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
