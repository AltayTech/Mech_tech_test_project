import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:magic_tech_test_project/main.dart' as app;
import 'package:magic_tech_test_project/widget/workout_listview_item.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        'tap on the floating action button, next page,add new record and remove',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the list screen.
      expect(find.text('Bills'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('New Record');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // // Verify that navigate to new record screen.
      expect(find.text('Select Your workout'), findsOneWidget);

      // Finds the floating action button to tap on to confirm new record.
      final Finder confirm_fab = find.byTooltip('Confirm');

      // Emulate a tap on the floating action button.
      await tester.tap(confirm_fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // // Verify the first record item appeared on the screen.
      expect(find.text('No 1'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder dismissible = find.byType(WorkoutListviewItem);

      // Swipe the item to dismiss it.
      await tester.drag(dismissible, const Offset(100000.0, 0.0));

      // Build the widget until the dismiss animation ends.
      await tester.pumpAndSettle();

      // Ensure that the item is no longer on screen.
      expect(find.text('No 1'), findsNothing);
    });
  });
}
