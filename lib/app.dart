import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/portfolio_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arnob Das | Portfolio',
      theme: AppTheme.dark,
      home: const PortfolioScreen(),
    );
  }
}