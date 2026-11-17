import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordPage extends GetView<AuthController> {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    final id = TextEditingController();
    return AuthScaffold(title: 'استعادة كلمة المرور', subtitle: 'أدخل بريدك الإلكتروني أو رقمك الأكاديمي', child: Form(key: controller.forgotFormKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)), child: const Text('سنرسل رمز تحقق من 6 أرقام لإعادة تعيين كلمة المرور. الرمز التجريبي هو 123456.', textAlign: TextAlign.center)),
      const SizedBox(height: 20), AuthTextField(controller: id, label: 'البريد الإلكتروني أو الرقم الأكاديمي', icon: Icons.alternate_email, validator: FormValidators.loginIdentifier),
      const SizedBox(height: 20), Obx(() => FilledButton(onPressed: controller.isLoading.value ? null : () => controller.requestReset(id.text), child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('إرسال رمز التحقق'))),
    ])));
  }
}
