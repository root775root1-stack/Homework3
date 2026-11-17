import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_field.dart';

final _key = GlobalKey<FormState>();

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(authProvider);
    final n = ref.read(authProvider.notifier);
    return AuthCard(title: 'إنشاء حساب طالب', subtitle: 'أكمل البيانات التالية',
      child: Form(key: _key, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        AuthField(label: 'الاسم الكامل', icon: Icons.badge_outlined,
          validator: Validators.name, onChanged: n.setName),
        const SizedBox(height: 12),
        AuthField(label: 'الرقم الأكاديمي', icon: Icons.numbers,
          keyboardType: TextInputType.number, maxLength: 10,
          validator: Validators.studentId, onChanged: n.setStudentId),
        const SizedBox(height: 12),
        AuthField(label: 'البريد الإلكتروني', icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress, validator: Validators.email, onChanged: n.setEmail),
        const SizedBox(height: 12),
        AuthField(label: 'كلمة المرور', icon: Icons.lock_outline, obscure: s.hidePassword,
          validator: Validators.strongPassword, onChanged: n.setPassword,
          suffix: IconButton(onPressed: n.togglePassword,
            icon: Icon(s.hidePassword ? Icons.visibility : Icons.visibility_off))),
        const SizedBox(height: 12),
        AuthField(label: 'تأكيد كلمة المرور', icon: Icons.lock_reset, obscure: s.hideConfirm,
          validator: (v) => Validators.confirm(v, s.password), onChanged: n.setConfirm,
          suffix: IconButton(onPressed: n.toggleConfirm,
            icon: Icon(s.hideConfirm ? Icons.visibility : Icons.visibility_off))),
        CheckboxListTile(contentPadding: EdgeInsets.zero, value: s.acceptedTerms,
          onChanged: (_) => n.toggleTerms(), title: const Text('أوافق على الشروط والأحكام'),
          controlAffinity: ListTileControlAffinity.leading),
        FilledButton(onPressed: s.loading ? null : () async {
          if (!(_key.currentState?.validate() ?? false)) return;
          if (!s.acceptedTerms) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يجب الموافقة على الشروط والأحكام.')));
            return;
          }
          final result = await n.register();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result.message),
            backgroundColor: result.success ? Colors.green : Colors.red));
          if (result.success) { n.clear(); Navigator.pop(context); }
        }, child: s.loading ? const CircularProgressIndicator() : const Text('إنشاء الحساب')),
      ])));
  }
}
