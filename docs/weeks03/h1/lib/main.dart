import 'package:flutter/material.dart';
import 'screens/tcg_vault_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCG Vault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.material3DarkTheme,
      home: const TcgVaultScreen(),
    );
  }
}