import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../responsive/responsive.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/services_section.dart';
import '../sections/portfolio_section.dart';
import '../sections/technologies_section.dart';
import '../sections/why_choose_us_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/contact_section.dart';
import '../sections/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  // Section global keys for smooth scrolling
  final List<GlobalKey> _sectionKeys = List.generate(8, (_) => GlobalKey());
  
  // Scroll mapping:
  // 0: Home, 1: About, 2: Services, 3: Portfolio, 4: Technologies, 5: Why, 6: Testimonials, 7: Contact
  final List<Map<String, dynamic>> _navItems = [
    {'title': AppStrings.navHome, 'index': 0},
    {'title': AppStrings.navAbout, 'index': 1},
    {'title': AppStrings.navServices, 'index': 2},
    {'title': AppStrings.navPortfolio, 'index': 3},
    {'title': AppStrings.navTechnologies, 'index': 4},
    {'title': AppStrings.navContact, 'index': 7},
  ];

  int _currentActiveNavIndex = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Background opacity trigger
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }

    // Scroll active item highlight calculation
    const double navbarHeight = 80.0;
    int calculatedIndex = 0;
    double minDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          final dy = position.dy - navbarHeight;

          // We check which section is currently active/nearest to top
          if (dy.abs() < minDistance && dy <= 120) {
            minDistance = dy.abs();
            calculatedIndex = i;
          }
        }
      }
    }

    // Map internal indices
    int mappedIndex = calculatedIndex;
    if (calculatedIndex == 5) mappedIndex = 4; // Map "Why Choose Us" to "Technologies"
    if (calculatedIndex == 6) mappedIndex = 4; // Map "Testimonials" to "Technologies"
    
    // Bottom edge check (Highlight contact)
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 60) {
      mappedIndex = 7;
    }

    if (mappedIndex != _currentActiveNavIndex) {
      setState(() {
        _currentActiveNavIndex = mappedIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _buildNavigationBar(isDesktop),
      ),
      drawer: isDesktop ? null : _buildMobileDrawer(),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HeroSection(
                key: _sectionKeys[0],
                onContactPressed: () => _scrollToSection(7),
                onPortfolioPressed: () => _scrollToSection(3),
              ),
              AboutSection(key: _sectionKeys[1]),
              ServicesSection(key: _sectionKeys[2]),
              PortfolioSection(key: _sectionKeys[3]),
              TechnologiesSection(key: _sectionKeys[4]),
              WhyChooseUsSection(key: _sectionKeys[5]),
              TestimonialsSection(key: _sectionKeys[6]),
              ContactSection(key: _sectionKeys[7]),
              FooterSection(
                onLinkPressed: _scrollToSection,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar(bool isDesktop) {
    final horizontalPadding = isDesktop ? MediaQuery.sizeOf(context).width * 0.08 : 20.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _isScrolled ? AppColors.dark.withAlpha((0.95 * 255).toInt()) : AppColors.dark,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha((0.15 * 255).toInt()),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? Colors.white10 : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          GestureDetector(
            onTap: () => _scrollToSection(0),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.hexagon_outlined,
                    color: AppColors.accent,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    color: AppColors.light,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Actions
          if (isDesktop)
            Row(
              children: _navItems.map((item) {
                final int itemIndex = item['index'] as int;
                final bool isActive = _currentActiveNavIndex == itemIndex;
                
                return _buildNavbarLink(item['title'] as String, isActive, () {
                  _scrollToSection(itemIndex);
                });
              }).toList(),
            )
          else
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.light),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              }
            ),
        ],
      ),
    );
  }

  Widget _buildNavbarLink(String title, bool isActive, VoidCallback onTap) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isActive 
                          ? AppColors.accent 
                          : (isHovered ? AppColors.light : AppColors.light.withAlpha((0.7 * 255).toInt())),
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    width: isActive ? 20 : (isHovered ? 12 : 0),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.dark,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.hexagon_outlined,
                          color: AppColors.accent,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        AppStrings.appName,
                        style: TextStyle(
                          color: AppColors.light,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.light),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.white10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                children: _navItems.map((item) {
                  final int itemIndex = item['index'] as int;
                  final bool isActive = _currentActiveNavIndex == itemIndex;
                  return ListTile(
                    leading: Icon(
                      _getIconForIndex(itemIndex),
                      color: isActive ? AppColors.accent : Colors.white60,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: isActive ? AppColors.accent : Colors.white,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _scrollToSection(itemIndex);
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    AppStrings.tagline,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white30, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.footerBottomText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0: return Icons.home_outlined;
      case 1: return Icons.info_outline;
      case 2: return Icons.work_outline;
      case 3: return Icons.grid_view_outlined;
      case 4: return Icons.code;
      case 7: return Icons.email_outlined;
      default: return Icons.widgets_outlined;
    }
  }
}
