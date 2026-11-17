import '../models/auth_result.dart';
import '../models/student_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl._();
  static final AuthRepositoryImpl shared = AuthRepositoryImpl._();
  final List<StudentModel> _students = [
    const StudentModel(fullName: 'Demo Student', studentId: '123456789', email: 'student@example.com', password: 'Student1'),
  ];
  String? _pendingResetIdentifier;
  bool _matches(StudentModel s, String id) => s.studentId.toLowerCase() == id.trim().toLowerCase() || s.email.toLowerCase() == id.trim().toLowerCase();

  @override
  Future<AuthResult> login({required String identifier, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final found = _students.any((s) => _matches(s, identifier) && s.password == password);
    return AuthResult(success: found, message: found ? 'تم تسجيل الدخول بنجاح.' : 'بيانات الدخول غير صحيحة.');
  }

  @override
  Future<AuthResult> register(StudentModel student) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (_students.any((s) => s.studentId == student.studentId || s.email.toLowerCase() == student.email.toLowerCase())) {
      return const AuthResult(success: false, message: 'الرقم الأكاديمي أو البريد مسجل مسبقاً.');
    }
    _students.add(student);
    return const AuthResult(success: true, message: 'تم إنشاء الحساب بنجاح.');
  }

  @override
  Future<AuthResult> requestPasswordReset(String identifier) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!_students.any((s) => _matches(s, identifier))) {
      return const AuthResult(success: false, message: 'لم يتم العثور على حساب بهذه البيانات.');
    }
    _pendingResetIdentifier = identifier.trim();
    return const AuthResult(success: true, message: 'رمز التحقق التجريبي هو 123456.');
  }

  @override
  Future<AuthResult> resetPassword({required String identifier, required String otp, required String newPassword}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (otp != '123456' || _pendingResetIdentifier?.toLowerCase() != identifier.trim().toLowerCase()) {
      return const AuthResult(success: false, message: 'رمز التحقق أو بيانات الحساب غير صحيحة.');
    }
    final index = _students.indexWhere((s) => _matches(s, identifier));
    if (index < 0) return const AuthResult(success: false, message: 'الحساب غير موجود.');
    _students[index] = _students[index].copyWith(password: newPassword);
    _pendingResetIdentifier = null;
    return const AuthResult(success: true, message: 'تم تحديث كلمة المرور بنجاح.');
  }
}
