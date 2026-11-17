import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(), id = TextEditingController(), email = TextEditingController(), password = TextEditingController(), confirm = TextEditingController();
    final accepted = false.obs;
    return AuthScaffold(title: 'إنشاء حساب طالب', subtitle: 'أكمل البيانات التالية لإنشاء حسابك', child: Form(key: controller.registerFormKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      AuthTextField(controller: name, label: 'الاسم الكامل', icon: Icons.badge_outlined, validator: FormValidators.fullName),
      const SizedBox(height: 14), AuthTextField(controller: id, label: 'الرقم الأكاديمي', icon: Icons.numbers, keyboardType: TextInputType.number, maxLength: 10, validator: FormValidators.studentId),
      const SizedBox(height: 14), AuthTextField(controller: email, label: 'البريد الإلكتروني', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: FormValidators.email),
      const SizedBox(height: 14), Obx(() => AuthTextField(controller: password, label: 'كلمة المرور', icon: Icons.lock_outline, obscureText: controller.obscurePassword.value, validator: FormValidators.strongPassword, suffix: IconButton(onPressed: controller.togglePassword, icon: Icon(controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
      const SizedBox(height: 14), Obx(() => AuthTextField(controller: confirm, label: 'تأكيد كلمة المرور', icon: Icons.lock_reset, obscureText: controller.obscureConfirmPassword.value, validator: (v) => FormValidators.confirmPassword(v, password.text), suffix: IconButton(onPressed: controller.toggleConfirmPassword, icon: Icon(controller.obscureConfirmPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
      Obx(() => CheckboxListTile(contentPadding: EdgeInsets.zero, value: accepted.value, onChanged: (v) => accepted.value = v ?? false, title: const Text('أوافق على الشروط والأحكام'), controlAffinity: ListTileControlAffinity.leading)),
      Obx(() => FilledButton(onPressed: controller.isLoading.value ? null : () {
        if (!accepted.value) { Get.snackbar('تنبيه', 'يجب الموافقة على الشروط والأحكام.', backgroundColor: Colors.orange.shade100); return; }
        controller.register(fullName: name.text, studentId: id.text, email: email.text, password: password.text);
      }, child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('إنشاء الحساب'))),
    ])));
  }
}
