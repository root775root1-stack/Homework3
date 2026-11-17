import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/student_model.dart';
import '../repositories/auth_repository.dart';
import '../utils/app_routes.dart';

class AuthController extends GetxController {
  AuthController({required this.repository});
  final AuthRepository repository;
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final rememberMe = false.obs;
  final resetIdentifier = ''.obs;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  void togglePassword() => obscurePassword.toggle();
  void toggleConfirmPassword() => obscureConfirmPassword.toggle();
  void toggleRememberMe() => rememberMe.toggle();
  void _error(String message) => Get.snackbar('تنبيه', message, backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);

  Future<void> login(String id, String password) async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      final result = await repository.login(identifier: id, password: password);
      if (result.success) {
        Get.snackbar('نجاح', result.message, backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
      } else { _error(result.message); }
    } finally { isLoading.value = false; }
  }

  Future<void> register({required String fullName, required String studentId, required String email, required String password}) async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      final result = await repository.register(StudentModel(fullName: fullName.trim(), studentId: studentId.trim(), email: email.trim(), password: password));
      if (result.success) {
        Get.snackbar('نجاح', result.message, backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
        Get.offAllNamed(AppRoutes.login);
      } else { _error(result.message); }
    } finally { isLoading.value = false; }
  }

  Future<void> requestReset(String id) async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      final result = await repository.requestPasswordReset(id);
      if (result.success) {
        resetIdentifier.value = id.trim();
        Get.snackbar('تم الإرسال', result.message, backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900, duration: const Duration(seconds: 4));
        Get.toNamed(AppRoutes.resetPassword);
      } else { _error(result.message); }
    } finally { isLoading.value = false; }
  }

  Future<void> resetPassword({required String otp, required String newPassword}) async {
    if (!(resetFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      final result = await repository.resetPassword(identifier: resetIdentifier.value, otp: otp.trim(), newPassword: newPassword);
      if (result.success) {
        Get.defaultDialog(title: 'تم بنجاح', middleText: result.message, textConfirm: 'العودة لتسجيل الدخول', confirmTextColor: Colors.white, onConfirm: () => Get.offAllNamed(AppRoutes.login));
      } else { _error(result.message); }
    } finally { isLoading.value = false; }
  }
}
