# ونيس

تطبيق محادثة عربي RTL مبني بـ Flutter، ومهيأ للويب أولاً مع قابلية البناء لاحقاً لـ Android وiOS.

## التشغيل على Codespaces

```bash
flutter pub get
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

لتفعيل Gemini، مرّر المفتاح من خارج الكود:

```bash
flutter run -d chrome --dart-define=GEMINI_API_KEY=YOUR_KEY
flutter build web --dart-define=GEMINI_API_KEY=YOUR_KEY
```

عند عدم تمرير المفتاح يعمل التطبيق بردود محلية تجريبية. لا تضع المفتاح في ملفات المشروع أو في Git.

## تنظيم المشروع

- `lib/screens`: الصفحات والتنقل.
- `lib/widgets`: المكونات المشتركة.
- `lib/theme`: الألوان والخطوط والثيمات.
- `lib/services`: التكامل مع Gemini.