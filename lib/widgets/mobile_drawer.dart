import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import 'profile_avatar.dart';

class MobileDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onClose;

  const MobileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onClose,
  });

  static const items = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Journey',
    'Contact',
  ];

  static const icons = [
    Icons.home_rounded,
    Icons.person_rounded,
    Icons.code_rounded,
    Icons.work_rounded,
    Icons.route_rounded,
    Icons.mail_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 290,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border(
            right: BorderSide(
              color: AppTheme.neonPurple.withValues(alpha: 0.3),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonPurple.withValues(alpha: 0.18),
              blurRadius: 35,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        AppConstants.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close_rounded),
                      color: AppTheme.textSecondary,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Profile
                const ProfileAvatar(
                  size: 76,
                ),

                const SizedBox(height: 14),

                const Text(
                  AppConstants.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'SOFTWARE ENGINEER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.neonCyan,
                    fontSize: 9,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final selected = selectedIndex == index;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onItemSelected(index),
                          borderRadius: BorderRadius.circular(14),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppTheme.neonPurple
                                      .withValues(alpha: 0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: selected
                                    ? AppTheme.neonPurple
                                        .withValues(alpha: 0.4)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  icons[index],
                                  size: 20,
                                  color: selected
                                      ? AppTheme.neonCyan
                                      : AppTheme.textSecondary,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                    color: selected
                                        ? AppTheme.textPrimary
                                        : AppTheme.textSecondary,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  '© ${DateTime.now().year} ${AppConstants.name}',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}