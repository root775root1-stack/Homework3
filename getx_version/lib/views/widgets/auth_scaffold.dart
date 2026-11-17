import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 460), child: Card(
        color: Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CircleAvatar(radius: 30, backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Icon(Icons.school, size: 32, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 18), Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 26), child,
        ])),
      )),
    ))),
  );
}
