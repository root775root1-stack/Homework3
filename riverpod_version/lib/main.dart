import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';

void main() => runApp(const ProviderScope(child: StudentAuthApp()));

class StudentAuthApp extends StatelessWidget {
  const StudentAuthApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Student Authentication - Riverpod',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    initialRoute: '/',
    routes: AppRoutes.routes,
  );
}
