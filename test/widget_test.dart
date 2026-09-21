import 'package:flutter_test/flutter_test.dart';
import 'package:wanees/main.dart';

void main() {
  testWidgets('Wanees app starts', (tester) async {
    await tester.pumpWidget(const WaneesApp());

    expect(find.text('ونيس'), findsWidgets);
  });
}
