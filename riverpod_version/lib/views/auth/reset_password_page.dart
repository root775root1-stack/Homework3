import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_field.dart';

final _key = GlobalKey<FormState>();

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(authProvider);
    final n = ref.read(authProvider.notifier);
    return AuthCard(title: 'تعيين كلمة مرور جديدة', subtitle: 'أدخل رمز التحقق وكلمة المرور الجديدة',
      child: Form(key: _key, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        AuthField(label: 'رمز التحقق (6 أرقام)', icon: Icons.pin,
          keyboardType: TextInputType.number, maxLength: 6,
          validator: Validators.otp, onChanged: n.setOtp),
        const SizedBox(height: 12),
        AuthField(label: 'كلمة المرور الجديدة', icon: Icons.lock_outline,
          obscure: s.hidePassword, validator: Validators.strongPassword, onChanged: n.setPassword,
          suffix: IconButton(onPressed: n.togglePassword,
            icon: Icon(s.hidePassword ? Icons.visibility : Icons.visibility_off))),
        const SizedBox(height: 12),
        AuthField(label: 'تأكيد كلمة المرور', icon: Icons.lock_reset,
          obscure: s.hideConfirm, validator: (v) => Validators.confirm(v, s.password),
          onChanged: n.setConfirm, suffix: IconButton(onPressed: n.toggleConfirm,
            icon: Icon(s.hideConfirm ? Icons.visibility : Icons.visibility_off))),
        const SizedBox(height: 18),
        FilledButton(onPressed: s.loading ? null : () async {
          if (!(_key.currentState?.validate() ?? false)) return;
          final result = await n.resetPassword();
          if (!context.mounted) return;
          if (result.success) {
            await showDialog<void>(context: context, builder: (ctx) => AlertDialog(
              title: const Text('تم بنجاح'),
              content: Text(result.message),
              actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('حسناً'))]));
            if (!context.mounted) return;
            n.clear();
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result.message), backgroundColor: Colors.red));
          }
        }, child: s.loading ? const CircularProgressIndicator() : const Text('تحديث كلمة المرور')),
      ])));
  }
}
