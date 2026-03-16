import 'package:flutter/material.dart';

import 'core/design_system/theme.dart';

void main() {
  runApp(const DeelMarktApp());
}

class DeelMarktApp extends StatelessWidget {
  const DeelMarktApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeelMarkt',
      debugShowCheckedModeBanner: false,
      theme: DeelmarktTheme.light,
      darkTheme: DeelmarktTheme.dark,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(child: Text('DeelMarkt — Deel wat je hebt')),
      ),
    );
  }
}
