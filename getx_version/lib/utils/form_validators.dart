class FormValidators {
  static String? loginIdentifier(String? v) => (v == null || v.trim().length < 5) ? 'أدخل معرفاً أو بريداً من 5 خانات على الأقل.' : null;
  static String? loginPassword(String? v) => (v == null || v.length < 6) ? 'كلمة المرور يجب ألا تقل عن 6 خانات.' : null;
  static String? fullName(String? v) => (v == null || v.trim().length < 3) ? 'الاسم يجب ألا يقل عن 3 أحرف.' : null;
  static String? studentId(String? v) => (v == null || !RegExp(r'^\d{9,10}$').hasMatch(v.trim())) ? 'الرقم الأكاديمي يجب أن يتكون من 9 أو 10 أرقام.' : null;
  static String? email(String? v) => (v == null || !RegExp(r'^[\w.+-]+@[\w-]+\.[A-Za-z]{2,}$').hasMatch(v.trim())) ? 'أدخل بريداً إلكترونياً صحيحاً.' : null;
  static String? strongPassword(String? v) {
    final p = v ?? '';
    if (p.length < 8) return 'كلمة المرور يجب ألا تقل عن 8 خانات.';
    if (!RegExp(r'\d').hasMatch(p)) return 'يجب أن تحتوي على رقم واحد على الأقل.';
    if (!RegExp(r'[A-Z]').hasMatch(p)) return 'يجب أن تحتوي على حرف إنجليزي كبير.';
    return null;
  }
  static String? confirmPassword(String? v, String original) => (v == null || v.isEmpty) ? 'يرجى تأكيد كلمة المرور.' : (v != original ? 'كلمتا المرور غير متطابقتين.' : null);
  static String? otp(String? v) => (v == null || !RegExp(r'^\d{6}$').hasMatch(v.trim())) ? 'رمز التحقق يجب أن يتكون من 6 أرقام.' : null;
}
