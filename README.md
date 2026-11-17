# Student Authentication — GetX & Riverpod

يحتوي هذا المستودع مشروعين Flutter مستقلين ينفذان نظام المصادقة الطلابي نفسه باستخدام MVC وRepository Pattern.

- `getx_version/`: GetX باستخدام `GetxController` و`Obx`.
- `riverpod_version/`: Riverpod 2.x باستخدام `Notifier` و`NotifierProvider` و`ConsumerWidget`.

## التشغيل
ادخل إلى مجلد المشروع المطلوب ثم شغّل:
```bash
flutter pub get
flutter run
```

## بيانات الاختبار
- الرقم الأكاديمي: `123456789`
- كلمة المرور: `Student1`
- رمز OTP: `123456`

ملاحظة: كلا المشروعين يستخدمان تخزيناً تجريبياً في الذاكرة فقط.
