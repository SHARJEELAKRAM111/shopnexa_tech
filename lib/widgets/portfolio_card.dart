import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/project_model.dart';

class PortfolioCard extends StatefulWidget {
  final ProjectModel project;

  const PortfolioCard({super.key, required this.project});

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? AppColors.accent.withAlpha((0.3 * 255).toInt()) : Colors.grey.withAlpha((0.1 * 255).toInt()),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered 
                  ? AppColors.primary.withAlpha((0.1 * 255).toInt()) 
                  : Colors.black.withAlpha((0.04 * 255).toInt()),
              blurRadius: _isHovered ? 24 : 16,
              offset: _isHovered ? const Offset(0, 12) : const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visual Representation (Mockup / Draw)
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Stack(
                    children: [
                      // Vector Grid / Dot Pattern inside image area
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GridPatternPainter(),
                        ),
                      ),
                      // Animated accent glow
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        top: _isHovered ? 20 : -40,
                        right: _isHovered ? 20 : -40,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.accent.withAlpha((0.3 * 255).toInt()),
                          ),
                        ),
                      ),
                      // Mock Project Display
                      Center(
                        child: Icon(
                          _getIconForProject(widget.project.title),
                          size: 64,
                          color: AppColors.light,
                        ),
                      ),
                      // Floating Project Badge
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.dark.withAlpha((0.75 * 255).toInt()),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.project.tags.first,
                            style: const TextStyle(
                              color: AppColors.light,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Body Content
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          color: AppColors.dark,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      // Tags wrapped
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.tags
                            .map((tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha((0.08 * 255).toInt()),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForProject(String title) {
    if (title.contains('Banking')) return Icons.account_balance_wallet_outlined;
    if (title.contains('Commerce')) return Icons.shopping_bag_outlined;
    if (title.contains('Healthcare')) return Icons.medical_services_outlined;
    if (title.contains('School')) return Icons.school_outlined;
    if (title.contains('CRM')) return Icons.dashboard_outlined;
    if (title.contains('Tracking')) return Icons.local_shipping_outlined;
    return Icons.web_asset_outlined;
  }
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.light.withAlpha((0.15 * 255).toInt())
      ..strokeWidth = 1.0;

    const double step = 20.0;
    
    // Draw columns
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // Draw rows
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
