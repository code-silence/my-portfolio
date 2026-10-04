import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../widgets/profile_avatar.dart';

class SidePanel extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool compact;

  const SidePanel({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.compact = false,
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
    return Container(
      width: compact ? 82 : 250,
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.86),
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 22,
            vertical: 28,
          ),
          child: Column(
            children: [
              _buildProfile(),
              SizedBox(height: compact ? 35 : 45),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _NavItem(
                      label: items[index],
                      icon: icons[index],
                      selected: selectedIndex == index,
                      compact: compact,
                      onTap: () => onItemSelected(index),
                    );
                  },
                ),
              ),
              if (!compact)
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
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        const ProfileAvatar(
          size: 72,
        ),
        if (!compact) ...[
          const SizedBox(height: 16),
          const Text(
            AppConstants.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'SOFTWARE EINGINEER',
            style: TextStyle(
              color: AppTheme.neonCyan,
              fontSize: 9,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected
            ? AppTheme.neonPurple.withValues(alpha: 0.12)
            : Colors.transparent,
        border: Border.all(
          color: selected
              ? AppTheme.neonPurple.withValues(alpha: 0.35)
              : Colors.transparent,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppTheme.neonPurple.withValues(alpha: 0.08),
                  blurRadius: 18,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: compact
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 19,
            color: selected
                ? AppTheme.neonCyan
                : AppTheme.textSecondary,
          ),
          if (!compact) ...[
            const SizedBox(width: 13),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? AppTheme.textPrimary
                    : AppTheme.textSecondary,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );

    return Tooltip(
      message: compact ? label : '',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: content,
        ),
      ),
    );
  }
}