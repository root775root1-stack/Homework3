import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_field.dart';

final _key = GlobalKey<FormState>();

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(authProvider);
    final n = ref.read(authProvider.notifier);
    return AuthCard(title: 'استعادة كلمة المرور', subtitle: 'أدخل البريد أو الرقم الأكاديمي',
      child: Form(key: _key, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('سنرسل رمز تحقق من 6 أرقام. الرمز التجريبي هو 123456.',
          textAlign: TextAlign.center),
        const SizedBox(height: 18),
        AuthField(label: 'البريد الإلكتروني أو الرقم الأكاديمي',
          icon: Icons.alternate_email, validator: Validators.identifier, onChanged: n.setIdentifier),
        const SizedBox(height: 18),
        FilledButton(onPressed: s.loading ? null : () async {
          if (!(_key.currentState?.validate() ?? false)) return;
          final result = await n.requestReset();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result.message),
            backgroundColor: result.success ? Colors.green : Colors.red));
          if (result.success) Navigator.pushNamed(context, '/reset');
        }, child: s.loading ? const CircularProgressIndicator() : const Text('إرسال رمز التحقق')),
      ])));
  }
}
