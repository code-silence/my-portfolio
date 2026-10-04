import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class AboutVisual extends StatelessWidget {
  const AboutVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppTheme.neonPurple.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonPurple.withValues(alpha: 0.05),
            blurRadius: 35,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.neonCyan,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.neonCyan,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'ABOUT // ARNOB',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'BUILDING IDEAS INTO\nREAL SOFTWARE.',
            style: TextStyle(
              fontSize: 28,
              height: 1.15,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'I enjoy taking an idea, breaking it down, and turning '
            'it into something people can actually use.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.07),
          ),
          const SizedBox(height: 22),
          const _AboutPoint(
            icon: Icons.phone_android_rounded,
            title: 'Mobile First',
            description:
                'Focused on building modern mobile experiences.',
          ),
          const SizedBox(height: 18),
          const _AboutPoint(
            icon: Icons.auto_awesome_rounded,
            title: 'Always Exploring',
            description:
                'Learning new technologies through real projects.',
          ),
          const SizedBox(height: 18),
          const _AboutPoint(
            icon: Icons.build_rounded,
            title: 'Hands-on',
            description:
                'I learn by building, experimenting and solving problems.',
          ),
        ],
      ),
    );
  }
}

class _AboutPoint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AboutPoint({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.neonPurple.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 19,
            color: AppTheme.neonCyan,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}