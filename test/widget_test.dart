
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/main.dart';

void main() {
  testWidgets('Aplikasi Course Explorer dapat dibuka',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CourseExplorerApp());

    expect(find.text('Ni Wayan Enzy Ariantini'), findsOneWidget);
  });
}