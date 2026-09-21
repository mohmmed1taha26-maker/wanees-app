import 'package:flutter_test/flutter_test.dart';
import 'package:wanees_app/main.dart';

void main() {
  testWidgets('يعرض تطبيق ونيس شاشة الدردشة', (tester) async {
    await tester.pumpWidget(const WaneesApp());

    expect(find.text('ونيس'), findsOneWidget);
    expect(find.text('اكتب رسالتك هنا...'), findsOneWidget);
  });
}
