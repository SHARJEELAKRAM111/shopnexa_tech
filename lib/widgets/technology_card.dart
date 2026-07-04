import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TechnologyCard extends StatefulWidget {
  final String name;
  final String category;

  const TechnologyCard({
    super.key,
    required this.name,
    required this.category,
  });

  @override
  State<TechnologyCard> createState() => _TechnologyCardState();
}

class _TechnologyCardState extends State<TechnologyCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = _getCategoryColor(widget.category);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(_isHovered ? 1.06 : 1.0, _isHovered ? 1.06 : 1.0, 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: _isHovered ? categoryColor.withAlpha((0.08 * 255).toInt()) : AppColors.light,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered 
                ? categoryColor.withAlpha((0.4 * 255).toInt()) 
                : Colors.grey.withAlpha((0.15 * 255).toInt()),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered 
                  ? categoryColor.withAlpha((0.12 * 255).toInt()) 
                  : Colors.black.withAlpha((0.02 * 255).toInt()),
              blurRadius: _isHovered ? 16 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tech indicator (Icon)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: categoryColor.withAlpha((0.12 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForTech(widget.name),
                size: 22,
                color: categoryColor,
              ),
            ),
            const SizedBox(width: 14),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.category,
                    style: TextStyle(
                      color: categoryColor.withAlpha((0.8 * 255).toInt()),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'frontend':
        return AppColors.primary;
      case 'backend':
        return AppColors.secondary;
      case 'database':
        return AppColors.accent;
      case 'cloud':
        return const Color(0xFFEA580C); // Warm Orange
      default:
        return AppColors.primary;
    }
  }

  IconData _getIconForTech(String name) {
    final n = name.toLowerCase();
    if (n.contains('flutter')) return Icons.phone_android;
    if (n.contains('react')) return Icons.code;
    if (n.contains('next.js')) return Icons.developer_mode;
    if (n.contains('node')) return Icons.javascript;
    if (n.contains('laravel')) return Icons.lan;
    if (n.contains('firebase')) return Icons.local_fire_department;
    if (n.contains('mysql')) return Icons.storage;
    if (n.contains('postgres')) return Icons.dns;
    if (n.contains('mongo')) return Icons.table_chart;
    if (n.contains('aws')) return Icons.cloud_queue;
    if (n.contains('google cloud')) return Icons.cloud_done;
    if (n.contains('vercel')) return Icons.cloud_upload;
    return Icons.widgets;
  }
}
