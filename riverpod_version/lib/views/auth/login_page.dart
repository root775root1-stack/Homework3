import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_field.dart';

final _key = GlobalKey<FormState>();

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(authProvider);
    final n = ref.read(authProvider.notifier);
    return AuthCard(title: 'تسجيل دخول الطالب', subtitle: 'أدخل بياناتك الأكاديمية للمتابعة',
      child: Form(key: _key, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        AuthField(label: 'المعرف الأكاديمي أو البريد الإلكتروني', icon: Icons.person_outline,
          validator: Validators.identifier, onChanged: n.setIdentifier),
        const SizedBox(height: 14),
        AuthField(label: 'كلمة المرور', icon: Icons.lock_outline, obscure: s.hidePassword,
          validator: Validators.loginPassword, onChanged: n.setPassword,
          suffix: IconButton(onPressed: n.togglePassword,
            icon: Icon(s.hidePassword ? Icons.visibility : Icons.visibility_off))),
        CheckboxListTile(contentPadding: EdgeInsets.zero, value: s.remember,
          onChanged: (_) => n.toggleRemember(), title: const Text('تذكرني'),
          controlAffinity: ListTileControlAffinity.leading),
        Align(alignment: AlignmentDirectional.centerEnd,
          child: TextButton(onPressed: () => Navigator.pushNamed(context, '/forgot'),
            child: const Text('نسيت كلمة المرور؟'))),
        FilledButton(onPressed: s.loading ? null : () async {
          if (!(_key.currentState?.validate() ?? false)) return;
          final result = await n.login();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result.message),
            backgroundColor: result.success ? Colors.green : Colors.red));
        }, child: s.loading ? const CircularProgressIndicator() : const Text('تسجيل الدخول')),
        TextButton(onPressed: () => Navigator.pushNamed(context, '/register'),
          child: const Text('ليس لديك حساب؟ إنشاء حساب جديد')),
        const Text('تجريبي: 123456789 / Student1', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey)),
      ])));
  }
}
