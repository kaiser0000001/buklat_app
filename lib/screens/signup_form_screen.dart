// filepath: lib/screens/signup_form_screen.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/form_widgets.dart';
import '../widgets/password_strength_indicator.dart';
import 'verification_screen.dart';

class SignUpFormScreen extends StatefulWidget {
  final bool isStudent;

  const SignUpFormScreen({super.key, required this.isStudent});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _middleInitialCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _sectionCtrl = TextEditingController();

  bool _obscure = true;
  String? _selectedGrade;

  // Password strength indicators
  bool _hasMinLength = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleInitialCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _sectionCtrl.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationScreen(
          email: _emailCtrl.text,
          phone: _phoneCtrl.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryBlue, secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.isStudent ? 'Student Registration' : 'Teacher Registration',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Fields
                        _buildNameFields(isWideScreen),
                        const SizedBox(height: 20),

                        // Contact Information
                        _buildContactFields(isWideScreen),
                        const SizedBox(height: 20),

                        // Password
                        buildLabel('Password'),
                        buildPasswordField(
                          controller: _passwordCtrl,
                          obscure: _obscure,
                          onChanged: _checkPasswordStrength,
                          onToggleVisibility: () => setState(() => _obscure = !_obscure),
                          hasMinLength: _hasMinLength,
                          hasUpperCase: _hasUpperCase,
                          hasNumber: _hasNumber,
                          hasSpecialChar: _hasSpecialChar,
                        ),
                        const SizedBox(height: 12),

                        // Password Strength Indicators
                        PasswordStrengthIndicator(
                          hasMinLength: _hasMinLength,
                          hasUpperCase: _hasUpperCase,
                          hasNumber: _hasNumber,
                          hasSpecialChar: _hasSpecialChar,
                        ),
                        const SizedBox(height: 20),

                        // Grade Level and Section
                        _buildAcademicFields(isWideScreen),
                        const SizedBox(height: 32),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primaryBlue,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Continue to Verification',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameFields(bool isWideScreen) {
    if (isWideScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('First Name'),
                buildTextField(
                  controller: _firstNameCtrl,
                  hint: 'Enter your first name',
                  icon: Icons.person_outline,
                  validator: (v) => v == null || v.trim().isEmpty ? 'First name is required' : null,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('M.I.'),
                buildTextField(
                  controller: _middleInitialCtrl,
                  hint: 'M.I.',
                  icon: Icons.person_outline,
                  maxLength: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('Last Name'),
                buildTextField(
                  controller: _lastNameCtrl,
                  hint: 'Enter your last name',
                  icon: Icons.person_outline,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Last name is required' : null,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('First Name'),
          buildTextField(
            controller: _firstNameCtrl,
            hint: 'Enter your first name',
            icon: Icons.person_outline,
            validator: (v) => v == null || v.trim().isEmpty ? 'First name is required' : null,
          ),
          const SizedBox(height: 20),
          buildLabel('Middle Initial'),
          buildTextField(
            controller: _middleInitialCtrl,
            hint: 'M.I.',
            icon: Icons.person_outline,
            maxLength: 2,
          ),
          const SizedBox(height: 20),
          buildLabel('Last Name'),
          buildTextField(
            controller: _lastNameCtrl,
            hint: 'Enter your last name',
            icon: Icons.person_outline,
            validator: (v) => v == null || v.trim().isEmpty ? 'Last name is required' : null,
          ),
        ],
      );
    }
  }

  Widget _buildContactFields(bool isWideScreen) {
    if (isWideScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('Phone Number'),
                buildTextField(
                  controller: _phoneCtrl,
                  hint: 'Enter your phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Phone number is required';
                    if (v.length < 10) return 'Enter a valid phone number';
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('Email'),
                buildTextField(
                  controller: _emailCtrl,
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('Phone Number'),
          buildTextField(
            controller: _phoneCtrl,
            hint: 'Enter your phone number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Phone number is required';
              if (v.length < 10) return 'Enter a valid phone number';
              return null;
            },
          ),
          const SizedBox(height: 20),
          buildLabel('Email'),
          buildTextField(
            controller: _emailCtrl,
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email is required';
              if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
              return null;
            },
          ),
        ],
      );
    }
  }

  Widget _buildAcademicFields(bool isWideScreen) {
    if (isWideScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('Grade Level'),
                buildGradeLevelDropdown(
                  selectedGrade: _selectedGrade,
                  onChanged: (value) => setState(() => _selectedGrade = value),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel('Section'),
                buildTextField(
                  controller: _sectionCtrl,
                  hint: 'e.g., A, B, Rose',
                  icon: Icons.class_outlined,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Section is required' : null,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('Grade Level'),
          buildGradeLevelDropdown(
            selectedGrade: _selectedGrade,
            onChanged: (value) => setState(() => _selectedGrade = value),
          ),
          const SizedBox(height: 20),
          buildLabel('Section'),
          buildTextField(
            controller: _sectionCtrl,
            hint: 'e.g., A, B, Rose',
            icon: Icons.class_outlined,
            validator: (v) => v == null || v.trim().isEmpty ? 'Section is required' : null,
          ),
        ],
      );
    }
  }
}

