// filepath: lib/widgets/form_widgets.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  int? maxLength,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLength: maxLength,
    style: const TextStyle(color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 15,
      ),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.8)),
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
    validator: validator,
  );
}

Widget buildPasswordField({
  required TextEditingController controller,
  required bool obscure,
  required Function(String) onChanged,
  required VoidCallback onToggleVisibility,
  required bool hasMinLength,
  required bool hasUpperCase,
  required bool hasNumber,
  required bool hasSpecialChar,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    onChanged: onChanged,
    style: const TextStyle(color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      hintText: 'Create a strong password',
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 15,
      ),
      prefixIcon: Icon(Icons.lock_outline, color: Colors.white.withOpacity(0.8)),
      suffixIcon: IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          obscure ? Icons.visibility_off : Icons.visibility,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
    validator: (v) {
      if (v == null || v.isEmpty) return 'Password is required';
      if (!hasMinLength) return 'Password must be at least 8 characters';
      if (!hasUpperCase) return 'Password needs an uppercase letter';
      if (!hasNumber) return 'Password needs a number';
      if (!hasSpecialChar) return 'Password needs a special character';
      return null;
    },
  );
}

Widget buildGradeLevelDropdown({
  required String? selectedGrade,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: selectedGrade,
    dropdownColor: primaryBlue,
    style: const TextStyle(color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      hintText: 'Select grade level',
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 15,
      ),
      prefixIcon: Icon(Icons.school_outlined, color: Colors.white.withOpacity(0.8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
    icon: Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.8)),
    items: ['Grade 4', 'Grade 5', 'Grade 6'].map((String grade) {
      return DropdownMenuItem<String>(
        value: grade,
        child: Text(grade, style: const TextStyle(color: Colors.white)),
      );
    }).toList(),
    onChanged: onChanged,
    validator: (v) => v == null ? 'Please select a grade level' : null,
  );
}

