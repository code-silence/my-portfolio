import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/project.dart';

class ProjectVisual extends StatelessWidget {
  final Project project;
  final bool large;

  const ProjectVisual({super.key, required this.project, this.large = false});

  @override
  Widget build(BuildContext context) {
    final height = large ? 310.0 : 190.0;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppTheme.neonPurple.withValues(alpha: 0.15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: project.imagePath != null ? _buildImage() : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Neon background
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.85,
              colors: [
                AppTheme.neonPurple.withValues(alpha: 0.10),
                AppTheme.background,
              ],
            ),
          ),
        ),

        // Full 1:1 project image
        Padding(
          padding: const EdgeInsets.all(28),
          child: Image.asset(
            project.imagePath!,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => _buildPlaceholder(),
          ),
        ),

        // Subtle bottom overlay
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
          ),
        ),


        Positioned(
          bottom: 16,
          right: 18,
          child: _label(project.name.toUpperCase(), cyan: true),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _ProjectGridPainter())),
        Center(
          child: Container(
            width: large ? 105 : 75,
            height: large ? 105 : 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.neonPurple.withValues(alpha: 0.07),
              border: Border.all(
                color: AppTheme.neonPurple.withValues(alpha: 0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.neonPurple.withValues(alpha: 0.12),
                  blurRadius: 35,
                ),
              ],
            ),
            child: Icon(
              project.placeholderIcon,
              size: large ? 48 : 34,
              color: AppTheme.neonCyan,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 18,
          child: _label(project.name.toUpperCase(), cyan: true),
        ),
      ],
    );
  }

  Widget _label(String text, {bool cyan = false}) {
    return Text(
      text,
      style: TextStyle(
        color: cyan ? AppTheme.neonCyan : AppTheme.textSecondary,
        fontSize: 8,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ProjectGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 1;

    const spacing = 28.0;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProjectGridPainter oldDelegate) {
    return false;
  }
}
