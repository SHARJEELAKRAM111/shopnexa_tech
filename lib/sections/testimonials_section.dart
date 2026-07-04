import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/testimonial_model.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/testimonial_card.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  late PageController _pageController;
  int _activePage = 0;

  static const List<TestimonialModel> testimonials = [
    TestimonialModel(
      name: 'Sarah Jenkins',
      company: 'CTO, PayFlow',
      review: 'ShopNexa Technologies delivered our mobile app ahead of schedule and with impeccable quality. Their engineering team was professional and highly responsive throughout the execution phases.',
      rating: 5,
      avatarUrl: '',
    ),
    TestimonialModel(
      name: 'David Chen',
      company: 'Founder, MedVitals',
      review: 'The custom SaaS healthcare system they developed is highly scalable, secure, and HIPAA-compliant. Strongly recommend them for complex software infrastructure needs.',
      rating: 5,
      avatarUrl: '',
    ),
    TestimonialModel(
      name: 'Elena Rostova',
      company: 'Director of Product, EduLearn',
      review: 'Their web platform designs completely revamped our online product presence. Excellent UI/UX sensibilities combined with stellar frontend execution under Flutter Web.',
      rating: 5,
      avatarUrl: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    return Container(
      width: double.infinity,
      color: AppColors.light,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.testimonialsTitle,
            subtitle: AppStrings.testimonialsSubtitle,
            description: 'Read testimonials from founders and technology leaders who partnered with ShopNexa Technologies to scale their products.',
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Testimonials container
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: testimonials
                  .map((t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            height: 300,
                            child: TestimonialCard(testimonial: t),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            mobile: Column(
              children: [
                SizedBox(
                  height: 320,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: testimonials.length,
                    onPageChanged: (page) {
                      setState(() {
                        _activePage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TestimonialCard(testimonial: testimonials[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Carousel Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    testimonials.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _activePage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _activePage == index ? AppColors.primary : Colors.grey.withAlpha((0.4 * 255).toInt()),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
