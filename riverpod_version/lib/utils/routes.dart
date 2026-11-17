import 'package:flutter/material.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/auth/forgot_password_page.dart';
import '../views/auth/reset_password_page.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/': (_) => const LoginPage(),
    '/register': (_) => const RegisterPage(),
    '/forgot': (_) => const ForgotPasswordPage(),
    '/reset': (_) => const ResetPasswordPage(),
  };
}
