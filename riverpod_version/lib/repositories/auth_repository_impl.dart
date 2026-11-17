import '../models/auth_result.dart';
import '../models/student.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl._();
  static final shared = AuthRepositoryImpl._();

  final List<Student> _students = [
    const Student(name: 'Demo Student', studentId: '123456789',
      email: 'student@example.com', password: 'Student1'),
  ];
  String? _pendingIdentifier;

  bool _matches(Student s, String id) =>
      s.studentId.toLowerCase() == id.trim().toLowerCase() ||
      s.email.toLowerCase() == id.trim().toLowerCase();

  @override
  Future<AuthResult> login(String identifier, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final ok = _students.any((s) => _matches(s, identifier) && s.password == password);
    return ok
      ? const AuthResult(true, 'تم تسجيل الدخول بنجاح.')
      : const AuthResult(false, 'بيانات الدخول غير صحيحة.');
  }

  @override
  Future<AuthResult> register(Student student) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (_students.any((s) => s.studentId == student.studentId ||
        s.email.toLowerCase() == student.email.toLowerCase())) {
      return const AuthResult(false, 'الرقم الأكاديمي أو البريد مسجل مسبقاً.');
    }
    _students.add(student);
    return const AuthResult(true, 'تم إنشاء الحساب بنجاح.');
  }

  @override
  Future<AuthResult> requestReset(String identifier) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!_students.any((s) => _matches(s, identifier))) {
      return const AuthResult(false, 'لم يتم العثور على الحساب.');
    }
    _pendingIdentifier = identifier.trim();
    return const AuthResult(true, 'تم إرسال رمز التحقق التجريبي. الرمز هو 123456.');
  }

  @override
  Future<AuthResult> resetPassword(String identifier, String otp, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (otp != '123456' || _pendingIdentifier == null ||
        _pendingIdentifier!.toLowerCase() != identifier.trim().toLowerCase()) {
      return const AuthResult(false, 'رمز التحقق أو بيانات الحساب غير صحيحة.');
    }
    final i = _students.indexWhere((s) => _matches(s, identifier));
    if (i < 0) return const AuthResult(false, 'الحساب غير موجود.');
    _students[i] = _students[i].copyWith(password: password);
    _pendingIdentifier = null;
    return const AuthResult(true, 'تم تحديث كلمة المرور بنجاح.');
  }
}
