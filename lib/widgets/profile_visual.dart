import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ProfileVisual extends StatefulWidget {
  const ProfileVisual({super.key});

  @override
  State<ProfileVisual> createState() => _ProfileVisualState();
}

class _ProfileVisualState extends State<ProfileVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.18,
      end: 0.32,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: MediaQuery.sizeOf(context).width < 500 ? 300 : 390,
          height: MediaQuery.sizeOf(context).width < 500 ? 390 : 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppTheme.neonPurple.withValues(
                  alpha: _glowAnimation.value,
                ),
                blurRadius: 60,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: AppTheme.surface.withValues(alpha: 0.9),
                  border: Border.all(
                    color: AppTheme.neonPurple.withValues(alpha: 0.55),
                    width: 1.2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: _buildPlaceholder(),
                ),
              ),
              _buildCornerDecorations(),
              _buildTopLabel(),
              _buildBottomLabel(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _VisualGridPainter())),
        Center(
          child: Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.neonPurple.withValues(alpha: 0.08),
              border: Border.all(
                color: AppTheme.neonPurple.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.neonPurple.withValues(alpha: 0.15),
                  blurRadius: 45,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpeg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.person_outline_rounded,
                    size: 72,
                    color: AppTheme.neonPurple,
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          left: 35,
          right: 35,
          bottom: MediaQuery.sizeOf(context).width < 500 ? 75 : 105,
          child: Column(
            children: [
              Container(
                height: 1,
                color: AppTheme.neonCyan.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 14),
              const Text(
                'PROFILE VISUAL',
                style: TextStyle(
                  color: AppTheme.neonCyan,
                  fontSize: 9,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'IMAGE SLOT',
                style: TextStyle(
                  color: AppTheme.textSecondary.withValues(alpha: 0.6),
                  fontSize: 9,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCornerDecorations() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(top: 18, left: 18, child: _corner(top: true, left: true)),
          Positioned(
            top: 18,
            right: 18,
            child: _corner(top: true, left: false),
          ),
          Positioned(
            bottom: 18,
            left: 18,
            child: _corner(top: false, left: true),
          ),
          Positioned(
            bottom: 18,
            right: 18,
            child: _corner(top: false, left: false),
          ),
        ],
      ),
    );
  }

  Widget _corner({required bool top, required bool left}) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(
        painter: _CornerPainter(
          color: AppTheme.neonCyan.withValues(alpha: 0.8),
          top: top,
          left: left,
        ),
      ),
    );
  }

  Widget _buildTopLabel() {
    return Positioned(
      top: 22,
      left: 26,
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.neonCyan,
              boxShadow: [BoxShadow(color: AppTheme.neonCyan, blurRadius: 8)],
            ),
          ),
          const SizedBox(width: 9),
          const Text(
            'PROFILE // 001',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomLabel() {
    return const Positioned(
      bottom: 24,
      right: 26,
      child: Text(
        'ARNOB.D',
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 9,
          letterSpacing: 2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _VisualGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 1;

    const spacing = 32.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final bool top;
  final bool left;

  const _CornerPainter({
    required this.color,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (top && left) {
      path
        ..moveTo(0, size.height)
        ..lineTo(0, 0)
        ..lineTo(size.width, 0);
    } else if (top && !left) {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height);
    } else if (!top && left) {
      path
        ..moveTo(0, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height);
    } else {
      path
        ..moveTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) {
    return false;
  }
}
