import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_routes.dart';
import '../../utils/form_validators.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final id = TextEditingController();
    final password = TextEditingController();
    return AuthScaffold(title: 'تسجيل دخول الطالب', subtitle: 'أدخل بياناتك الأكاديمية للمتابعة', child: Form(
      key: controller.loginFormKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        AuthTextField(controller: id, label: 'المعرف الأكاديمي أو البريد الإلكتروني', icon: Icons.person_outline, validator: FormValidators.loginIdentifier),
        const SizedBox(height: 16),
        Obx(() => AuthTextField(controller: password, label: 'كلمة المرور', icon: Icons.lock_outline, obscureText: controller.obscurePassword.value, validator: FormValidators.loginPassword,
          suffix: IconButton(onPressed: controller.togglePassword, icon: Icon(controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
        Obx(() => CheckboxListTile(contentPadding: EdgeInsets.zero, value: controller.rememberMe.value, onChanged: (_) => controller.toggleRememberMe(), title: const Text('تذكرني'), controlAffinity: ListTileControlAffinity.leading)),
        Align(alignment: AlignmentDirectional.centerEnd, child: TextButton(onPressed: () => Get.toNamed(AppRoutes.forgotPassword), child: const Text('نسيت كلمة المرور؟'))),
        Obx(() => FilledButton(onPressed: controller.isLoading.value ? null : () => controller.login(id.text, password.text), child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('تسجيل الدخول'))),
        const SizedBox(height: 12), TextButton(onPressed: () => Get.toNamed(AppRoutes.register), child: const Text('ليس لديك حساب؟ إنشاء حساب جديد')),
        const Text('حساب تجريبي: 123456789 / Student1', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    ));
  }
}
