import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class JourneyItem extends StatelessWidget {
  final String year;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final bool last;

  const JourneyItem({
    super.key,
    required this.year,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 82,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              year,
              style: const TextStyle(
                color: AppTheme.neonCyan,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.neonPurple.withValues(alpha: 0.12),
                  border: Border.all(
                    color: AppTheme.neonPurple.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.neonPurple.withValues(alpha: 0.12),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: AppTheme.neonCyan,
                ),
              ),
              if (!last)
                Container(
                  width: 1,
                  height: 105,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: AppTheme.neonPurple.withValues(alpha: 0.2),
                ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.neonPurple,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}