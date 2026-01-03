// filepath: lib/widgets/password_strength_indicator.dart
import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final bool hasMinLength;
  final bool hasUpperCase;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordStrengthIndicator({
    super.key,
    required this.hasMinLength,
    required this.hasUpperCase,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password must contain:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildStrengthItem('At least 8 characters', hasMinLength),
          _buildStrengthItem('One uppercase letter', hasUpperCase),
          _buildStrengthItem('One number', hasNumber),
          _buildStrengthItem('One special character (!@#\$%^&*)', hasSpecialChar),
        ],
      ),
    );
  }

  Widget _buildStrengthItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isMet ? Colors.green : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: isMet
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isMet ? Colors.white : Colors.white.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

