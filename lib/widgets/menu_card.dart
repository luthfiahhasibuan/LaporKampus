import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  final Gradient? gradient;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.gradient,
  });

  static const double _minHeight = 112;

  static const BorderRadius _shape = BorderRadius.only(
    topLeft: Radius.circular(32),
    bottomRight: Radius.circular(32),
    topRight: Radius.circular(8),
    bottomLeft: Radius.circular(8),
  );

  static const Gradient _defaultGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryLight, AppColors.primary, AppColors.primaryDark],
    stops: [0.0, 0.55, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return Container(
      decoration: BoxDecoration(
        borderRadius: _shape,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: _shape,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient ?? _defaultGradient,
            borderRadius: _shape,
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: _shape,
            splashColor: Colors.white.withValues(alpha: 0.15),
            highlightColor: Colors.white.withValues(alpha: 0.08),
            child: Stack(
              children: [
                _buildCircle(top: -34, right: -24, size: 120, alpha: 0.10),
                _buildCircle(bottom: -48, right: 70, size: 100, alpha: 0.07),
                _buildContent(r),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Lingkaran transparan
  Widget _buildCircle({
    double? top,
    double? bottom,
    double? right,
    required double size,
    required double alpha,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: alpha),
        ),
      ),
    );
  }

  Widget _buildContent(Responsive r) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 16, 16, 16),
        child: Row(
          children: [
            Expanded(child: _buildTexts(r)),
            const SizedBox(width: 12),
            _buildIconBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildTexts(r) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bold(
            r.font(4.4),
            color: AppColors.textGreen,
          ).copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTextStyles.regular(
            r.font(3.6),
            color: AppColors.textGrey,
          ).copyWith(color: Colors.white.withValues(alpha: 0.85)),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        _buildArrowPill(),
      ],
    );
  }

  Widget _buildArrowPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.arrow_forward_rounded,
        size: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _buildIconBadge() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
