import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.title, required this.subtitle, required this.child});
  final String title, subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 460),
        child: Card(color: Colors.white, child: Padding(padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(Icons.school_rounded, size: 48),
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            child,
          ]),
        )),
      ),
    ))),
  );
}
