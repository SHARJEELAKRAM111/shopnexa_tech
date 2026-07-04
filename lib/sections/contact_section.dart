import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show elegant success dialog / snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.accent),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Message Sent Successfully!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Thank you for reaching out. We will get back to you shortly.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.dark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 4),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _companyController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    return Container(
      width: double.infinity,
      color: AppColors.light,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.contactTitle,
            subtitle: AppStrings.contactSubtitle,
            description:
                'Have a project in mind or want to discuss a partnership? Send us a message and our expert developers will analyze your specifications.',
            isCenter: true,
          ),
          const SizedBox(height: 55),
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form on Left
                Expanded(flex: 6, child: _buildContactForm()),
                const SizedBox(width: 60),
                // Info on Right
                Expanded(flex: 4, child: _buildContactInfo()),
              ],
            ),
            mobile: Column(
              children: [
                _buildContactForm(),
                const SizedBox(height: 50),
                _buildContactInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withAlpha((0.08 * 255).toInt())),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send a Message',
              style: TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 24),
            // Name field
            _buildTextFormField(
              controller: _nameController,
              label: AppStrings.formName,
              icon: Icons.person_outline,
              validator: (val) => val == null || val.trim().isEmpty
                  ? AppStrings.validationRequired
                  : null,
            ),
            const SizedBox(height: 20),
            // Email and Phone (Side by side on desktop)
            Responsive(
              desktop: Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _emailController,
                      label: AppStrings.formEmail,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return AppStrings.validationRequired;
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(val)) {
                          return AppStrings.validationEmail;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _phoneController,
                      label: AppStrings.formPhone,
                      icon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return AppStrings.validationRequired;
                        }
                        final phoneRegex = RegExp(r'^\+?[0-9\s\-]{7,15}$');
                        if (!phoneRegex.hasMatch(val)) {
                          return AppStrings.validationPhone;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              mobile: Column(
                children: [
                  _buildTextFormField(
                    controller: _emailController,
                    label: AppStrings.formEmail,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return AppStrings.validationRequired;
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(val)) {
                        return AppStrings.validationEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    controller: _phoneController,
                    label: AppStrings.formPhone,
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return AppStrings.validationRequired;
                      }
                      final phoneRegex = RegExp(r'^\+?[0-9\s\-]{7,15}$');
                      if (!phoneRegex.hasMatch(val)) {
                        return AppStrings.validationPhone;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Company field
            _buildTextFormField(
              controller: _companyController,
              label: AppStrings.formCompany,
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: 20),
            // Message field
            _buildTextFormField(
              controller: _messageController,
              label: AppStrings.formMessage,
              icon: Icons.chat_bubble_outline,
              maxLines: 5,
              validator: (val) => val == null || val.trim().isEmpty
                  ? AppStrings.validationRequired
                  : null,
            ),
            const SizedBox(height: 32),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: AppStrings.formSubmit,
                onPressed: _submitForm,
                isPrimary: true,
                icon: Icons.send_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppColors.dark, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            color: AppColors.dark,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Reach out directly or visit our site. Our tech advisors are ready to support your business requirements.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.5,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        // Email row
        _buildInfoRow(
          Icons.email_outlined,
          'Email Address',
          AppStrings.contactEmail,
          'mailto:${AppStrings.contactEmail}',
        ),
        const SizedBox(height: 24),
        // Mobile row
        _buildInfoRow(
          Icons.phone_android_outlined,
          'Mobile Number',
          AppStrings.contactPhone,
          'tel:${AppStrings.contactPhone}',
        ),

        const SizedBox(height: 24),
        // Office Hours row
        _buildInfoRow(
          Icons.access_time_outlined,
          'Office Hours',
          AppStrings.contactHours,
          null,
        ),
        const SizedBox(height: 24),
        // Location row
        _buildInfoRow(
          Icons.location_on_outlined,
          'HQ Location',
          AppStrings.contactAddress,
          null,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String title,
    String value,
    String? actionUrl,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.08 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: actionUrl != null ? () {} : null, // Clickable items
                child: Text(
                  value,
                  style: TextStyle(
                    color: actionUrl != null
                        ? AppColors.primary
                        : AppColors.dark,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    decoration: actionUrl != null
                        ? TextDecoration.underline
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
