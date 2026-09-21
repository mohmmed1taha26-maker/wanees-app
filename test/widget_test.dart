import 'package:flutter_test/flutter_test.dart';
import 'package:wanees_app/main.dart';

void main() {
  testWidgets('يعرض تطبيق ونيس الصفحة الرئيسية والتنقل', (tester) async {
    await tester.pumpWidget(const WaneesApp());

    expect(find.text('ونيس'), findsWidgets);
    expect(find.text('مساحتك الآمنة للكلام'), findsOneWidget);
    expect(find.text('ابدأ محادثة جديدة'), findsOneWidget);

    await tester.tap(find.text('ابدأ محادثة جديدة'));
    await tester.pumpAndSettle();

    expect(find.text('أهلاً بك! أنا ونيس، كيف أستطيع مساعدتك اليوم؟'), findsOneWidget);
  });
}