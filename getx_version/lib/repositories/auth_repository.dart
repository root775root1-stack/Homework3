import '../models/auth_result.dart';
import '../models/student_model.dart';

abstract class AuthRepository {
  Future<AuthResult> login({required String identifier, required String password});
  Future<AuthResult> register(StudentModel student);
  Future<AuthResult> requestPasswordReset(String identifier);
  Future<AuthResult> resetPassword({required String identifier, required String otp, required String newPassword});
}
