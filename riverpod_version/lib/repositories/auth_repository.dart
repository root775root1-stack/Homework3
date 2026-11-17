import '../models/auth_result.dart';
import '../models/student.dart';

abstract class AuthRepository {
  Future<AuthResult> login(String identifier, String password);
  Future<AuthResult> register(Student student);
  Future<AuthResult> requestReset(String identifier);
  Future<AuthResult> resetPassword(String identifier, String otp, String password);
}
