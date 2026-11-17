import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository_impl.dart';
import 'utils/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = AuthRepositoryImpl.shared;
  runApp(StudentAuthApp(repository: repository));
}

class StudentAuthApp extends StatelessWidget {
  const StudentAuthApp({super.key, required this.repository});
  final AuthRepositoryImpl repository;

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Student Authentication - GetX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457A7)),
          scaffoldBackgroundColor: const Color(0xFFF4F6FA),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        initialBinding: BindingsBuilder(() => Get.put<AuthController>(
              AuthController(repository: repository), permanent: true)),
        initialRoute: AppRoutes.login,
        getPages: AppRoutes.pages,
      );
}
