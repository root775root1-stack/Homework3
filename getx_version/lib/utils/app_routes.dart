import 'package:get/get.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/auth/forgot_password_page.dart';
import '../views/auth/reset_password_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static final pages = <GetPage>[
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordPage()),
    GetPage(name: resetPassword, page: () => const ResetPasswordPage()),
  ];
}
