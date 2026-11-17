# Student Authentication — Riverpod 2.x

نسخة مستقلة من نظام المصادقة باستخدام Riverpod 2.x و`Notifier` و`NotifierProvider` و`ConsumerWidget`.

## التشغيل

```bash
flutter pub get
flutter run
```

## بيانات الاختبار
- الرقم الأكاديمي: `123456789`
- كلمة المرور: `Student1`
- OTP: `123456`

## المعمارية
MVC + Repository Pattern. إدارة الحالة تتم عبر `AuthNotifier`، وتقرأ الواجهات الحالة باستخدام `ref.watch` وتستدعي الأوامر باستخدام `ref.read`.

> التخزين تجريبي داخل الذاكرة فقط، وليس مناسباً للإنتاج دون خادم وقاعدة بيانات وخدمة OTP.
