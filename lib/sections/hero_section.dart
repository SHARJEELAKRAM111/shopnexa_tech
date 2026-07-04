import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactPressed;
  final VoidCallback onPortfolioPressed;

  const HeroSection({
    super.key,
    required this.onContactPressed,
    required this.onPortfolioPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.8, curve: Curves.easeOut)),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.9, curve: Curves.easeOutCubic)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: size.height - 80, // Sub navbar height
      ),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        gradient: AppColors.bgGradient,
      ),
      child: Stack(
        children: [
          // Background soft glowing spheres
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.softGlowGradient,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.softGlowGradient,
              ),
            ),
          ),
          
          // Main layout content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Responsive(
                    desktop: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildTextContent(isDesktop: true),
                        ),
                        const SizedBox(width: 40),
                        const Expanded(
                          flex: 5,
                          child: Center(
                            child: HeroIllustration(),
                          ),
                        ),
                      ],
                    ),
                    mobile: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        _buildTextContent(isDesktop: false),
                        const SizedBox(height: 60),
                        const SizedBox(
                          height: 320,
                          child: HeroIllustration(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent({required bool isDesktop}) {
    final align = isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlignment = isDesktop ? TextAlign.left : TextAlign.center;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pill tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.15 * 255).toInt()),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primary.withAlpha((0.3 * 255).toInt())),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Next-Gen Solutions Available',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Headline
        Text(
          AppStrings.heroHeadline,
          textAlign: textAlignment,
          style: TextStyle(
            color: AppColors.light,
            fontSize: isDesktop ? 54 : 36,
            fontWeight: FontWeight.w900,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 20),
        // Subheadline
        Text(
          AppStrings.heroSubheadline,
          textAlign: textAlignment,
          style: TextStyle(
            color: AppColors.light.withAlpha((0.75 * 255).toInt()),
            fontSize: isDesktop ? 18 : 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 36),
        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            CustomButton(
              text: AppStrings.heroPrimaryButton,
              onPressed: widget.onContactPressed,
              isPrimary: true,
              icon: Icons.rocket_launch_outlined,
            ),
            CustomButton(
              text: AppStrings.heroSecondaryButton,
              onPressed: widget.onPortfolioPressed,
              isPrimary: false,
              icon: Icons.arrow_forward_rounded,
            ),
          ],
        ),
      ],
    );
  }
}

// Stacked mockup illustrations for web
class HeroIllustration extends StatefulWidget {
  const HeroIllustration({super.key});

  @override
  State<HeroIllustration> createState() => _HeroIllustrationState();
}

class _HeroIllustrationState extends State<HeroIllustration> with SingleTickerProviderStateMixin {
  late AnimationController _levController;

  @override
  void initState() {
    super.initState();
    _levController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _levController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _levController,
      builder: (context, child) {
        final floatOffset = Offset(0, -15 * _levController.value);
        return Transform.translate(
          offset: floatOffset,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Outer glow
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withAlpha((0.15 * 255).toInt()),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withAlpha((0.2 * 255).toInt()),
                      blurRadius: 60,
                      spreadRadius: 20,
                    )
                  ],
                ),
              ),
              // Base Dashboard Mockup (Visual Card)
              Container(
                width: 360,
                height: 230,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withAlpha((0.12 * 255).toInt())),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Mock Header Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Row(
                        children: [
                          _buildDot(Colors.redAccent),
                          const SizedBox(width: 6),
                          _buildDot(Colors.amberAccent),
                          const SizedBox(width: 6),
                          _buildDot(Colors.greenAccent),
                          const SizedBox(width: 14),
                          Container(
                            height: 12,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha((0.1 * 255).toInt()),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    // Mock Content Grid
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Left sidebar mock
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha((0.03 * 255).toInt()),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(4, (_) => Container(
                                  height: 8,
                                  width: 24,
                                  color: Colors.white30,
                                )),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Right main mock content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 16, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4))),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(child: Container(height: 48, decoration: BoxDecoration(color: AppColors.primary.withAlpha((0.3 * 255).toInt()), borderRadius: BorderRadius.circular(8)))),
                                      const SizedBox(width: 12),
                                      Expanded(child: Container(height: 48, decoration: BoxDecoration(color: AppColors.accent.withAlpha((0.2 * 255).toInt()), borderRadius: BorderRadius.circular(8)))),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(height: 10, width: 100, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4))),
                                  const SizedBox(height: 8),
                                  Container(height: 10, width: 140, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Floating App Window Overlapping (Simulating multiplatform Web/App)
              Positioned(
                bottom: -30,
                right: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.accent.withAlpha((0.4 * 255).toInt())),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.4 * 255).toInt()),
                        blurRadius: 20,
                        offset: const Offset(-5, 10),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.show_chart, color: AppColors.accent, size: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withAlpha((0.15 * 255).toInt()),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Live', style: TextStyle(color: AppColors.accent, fontSize: 8, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Conversion',
                        style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        '+48.3%',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(4, (i) => Container(
                          height: 12,
                          width: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: i == 3 ? AppColors.accent : Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              // Floating Mobile Phone Window (Simulating mobile app development)
              Positioned(
                top: -40,
                left: -30,
                child: Container(
                  width: 90,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.4 * 255).toInt()),
                        blurRadius: 24,
                        offset: const Offset(5, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Speaker/Camera Notch
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 36,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Circle Profile Mock
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondary,
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 16),
                      ),
                      const SizedBox(height: 12),
                      Container(height: 6, width: 50, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(3))),
                      const SizedBox(height: 6),
                      Container(height: 6, width: 36, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(3))),
                      const Spacer(),
                      // Bottom navigation mock line
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        width: 40,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
