import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.9 * 255),
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _isFocused 
                    ? Colors.white.withOpacity(0.8)
                    : Colors.white.withOpacity(0.3),
                width: _isFocused ? 2 : 1,
              ),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? _obscureText : false,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.5 * 255),
                ),
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: Colors.white.withOpacity(0.7),
                        size: 20,
                      )
                    : null,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white.withOpacity(0.7),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : widget.suffixIcon != null
                        ? IconButton(
                            icon: Icon(
                              widget.suffixIcon,
                              color: Colors.white.withOpacity(0.7),
                              size: 20,
                            ),
                            onPressed: widget.onSuffixIconPressed,
                          )
                        : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.2),
      ],
    );
  }
}
