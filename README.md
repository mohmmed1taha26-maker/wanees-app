# ونيس - Wanees App

تطبيق Flutter بسيط وجميل للدردشة العربية، مع دعم Gemini API بدون حفظ مفتاح API داخل الكود.

## التشغيل

ثبت الحزم:

```bash
flutter pub get
```

## التشغيل على Codespaces

شغل التطبيق على منفذ `8080` مع تمرير مفتاح Gemini وقت التشغيل:

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080 --dart-define=GEMINI_API_KEY=YOUR_GEMINI_API_KEY
```

يمكن تغيير موديل Gemini عند الحاجة:

```bash
flutter run \
  --dart-define=GEMINI_API_KEY=YOUR_GEMINI_API_KEY \
  --dart-define=GEMINI_MODEL=gemini-1.5-flash
```

## ملاحظة مهمة

لا تضع مفتاح Gemini الحقيقي داخل `lib/main.dart` أو داخل GitHub. استخدم دائمًا `--dart-define` أو إعدادات سرية في نظام البناء.
