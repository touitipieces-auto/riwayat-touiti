# روايات التويتي — نسخة الشعار الجديدة

هذه النسخة تضيف شعار روايات التويتي الجديد داخل الواجهة الرئيسية للتطبيق.

## البناء على Codemagic
- Build platform: Android
- Format: APK
- Mode: Debug
- Post-clone script:
  `flutter create --platforms=android .`


## أيقونة التطبيق
تم إعداد `flutter_launcher_icons` لاستعمال `assets/logo.png` كأيقونة Android.
في Codemagic، يجب تشغيل الأمر التالي في مرحلة **Pre-build** بعد تثبيت dependencies:
`dart run flutter_launcher_icons`

ويظل **Post-clone** كما هو:
`flutter create --platforms=android .`
