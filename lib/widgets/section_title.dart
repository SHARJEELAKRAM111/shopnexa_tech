import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final bool isCenter;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.description,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final crossAlign = isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isCenter ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        Text(
          subtitle.toUpperCase(),
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
            color: AppColors.dark,
            fontWeight: FontWeight.w800,
            fontSize: 32,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        // Decorative glowing line
        Container(
          height: 4,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: AppColors.primaryGradient,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              description!,
              textAlign: textAlign,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
