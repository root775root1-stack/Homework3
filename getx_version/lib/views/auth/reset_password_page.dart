import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ResetPasswordPage extends GetView<AuthController> {
  const ResetPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    final otp = TextEditingController(), password = TextEditingController(), confirm = TextEditingController();
    return AuthScaffold(title: 'تعيين كلمة مرور جديدة', subtitle: 'أدخل رمز التحقق ثم كلمة المرور الجديدة', child: Form(key: controller.resetFormKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      AuthTextField(controller: otp, label: 'رمز التحقق (6 أرقام)', icon: Icons.pin_outlined, keyboardType: TextInputType.number, maxLength: 6, validator: FormValidators.otp),
      const SizedBox(height: 14), Obx(() => AuthTextField(controller: password, label: 'كلمة المرور الجديدة', icon: Icons.lock_outline, obscureText: controller.obscurePassword.value, validator: FormValidators.strongPassword, suffix: IconButton(onPressed: controller.togglePassword, icon: Icon(controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
      const SizedBox(height: 14), AuthTextField(controller: confirm, label: 'تأكيد كلمة المرور الجديدة', icon: Icons.lock_reset, obscureText: true, validator: (v) => FormValidators.confirmPassword(v, password.text)),
      const SizedBox(height: 20), Obx(() => FilledButton(onPressed: controller.isLoading.value ? null : () => controller.resetPassword(otp: otp.text, newPassword: password.text), child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('تحديث كلمة المرور'))),
    ])));
  }
}
