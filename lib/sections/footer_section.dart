import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../responsive/responsive.dart';

class FooterSection extends StatelessWidget {
  final Function(int) onLinkPressed;

  const FooterSection({
    super.key,
    required this.onLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    return Container(
      color: AppColors.dark,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 80, horizontalPadding, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Branding
                Expanded(
                  flex: 4,
                  child: _buildBranding(),
                ),
                const SizedBox(width: 40),
                // Quick links
                Expanded(
                  flex: 2,
                  child: _buildQuickLinks(),
                ),
                const SizedBox(width: 40),
                // Services links
                Expanded(
                  flex: 3,
                  child: _buildServicesList(),
                ),
              ],
            ),
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBranding(),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildQuickLinks()),
                    Expanded(child: _buildServicesList()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 30),
          // Bottom bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  AppStrings.footerBottomText,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                ),
              ),
              Row(
                children: [
                  _buildBottomTextLink('Privacy Policy'),
                  const SizedBox(width: 20),
                  _buildBottomTextLink('Terms of Service'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AppAssets.logo,
              height: 36,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.hexagon_outlined,
                color: AppColors.accent,
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                color: AppColors.light,
                fontWeight: FontWeight.w900,
                fontSize: 26,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.tagline,
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: const Text(
            'Specializing in creating high-quality mobile apps, web applications, SaaS platforms, and custom business integrations.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.quickLinks,
          style: TextStyle(
            color: AppColors.light,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        _buildFooterLink(AppStrings.navHome, () => onLinkPressed(0)),
        const SizedBox(height: 12),
        _buildFooterLink(AppStrings.navAbout, () => onLinkPressed(1)),
        const SizedBox(height: 12),
        _buildFooterLink(AppStrings.navServices, () => onLinkPressed(2)),
        const SizedBox(height: 12),
        _buildFooterLink(AppStrings.navPortfolio, () => onLinkPressed(3)),
        const SizedBox(height: 12),
        _buildFooterLink(AppStrings.navContact, () => onLinkPressed(7)), // Contact index
      ],
    );
  }

  Widget _buildServicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.servicesHeader,
          style: TextStyle(
            color: AppColors.light,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        _buildFooterLink('Mobile Development', () => onLinkPressed(2)),
        const SizedBox(height: 12),
        _buildFooterLink('Web Development', () => onLinkPressed(2)),
        const SizedBox(height: 12),
        _buildFooterLink('UI/UX Design', () => onLinkPressed(2)),
        const SizedBox(height: 12),
        _buildFooterLink('SaaS Solutions', () => onLinkPressed(2)),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(left: isHovered ? 8 : 0),
              child: Text(
                text,
                style: TextStyle(
                  color: isHovered ? AppColors.accent : Colors.white60,
                  fontSize: 14,
                  fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomTextLink(String text) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              text,
              style: TextStyle(
                color: isHovered ? AppColors.light : Colors.white38,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      },
    );
  }
}
