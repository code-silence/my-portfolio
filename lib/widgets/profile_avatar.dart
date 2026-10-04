import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ProfileAvatar extends StatefulWidget {
  final double size;

  const ProfileAvatar({
    super.key,
    this.size = 92,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glow = 0.16 + (_controller.value * 0.12);

        return Container(
          width: widget.size + 12,
          height: widget.size + 12,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.neonCyan.withValues(alpha: 0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.neonCyan.withValues(alpha: glow),
                blurRadius: 22,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: AppTheme.neonPurple.withValues(
                  alpha: glow * 0.7,
                ),
                blurRadius: 35,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppTheme.surface,
                  child: Icon(
                    Icons.person_rounded,
                    size: widget.size * 0.42,
                    color: AppTheme.neonCyan,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}