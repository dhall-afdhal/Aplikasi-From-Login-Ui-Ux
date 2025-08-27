import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE91E63), // Pink
              Color(0xFF673AB7), // Purple
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1 * 255),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2 * 255),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
                
                const SizedBox(height: 40),
                
                // App Logo/Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.2 * 255),
                        Colors.white.withValues(alpha: 0.1 * 255),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1 * 255),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 60,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 1000.ms).scale(begin: const Offset(0.8, 0.8)),
                
                const SizedBox(height: 30),
                
                // App Title
                Text(
                  'Modern Login App',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: -0.3),
                
                Text(
                  'Version 1.0.0',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8 * 255),
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideY(begin: -0.3),
                
                const SizedBox(height: 40),
                
                // App Description
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1 * 255),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2 * 255),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'About This App',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'A modern, beautiful Flutter application featuring 3D animations, glassmorphism design, and Supabase backend integration. This app demonstrates the latest Flutter development practices with stunning UI/UX design.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.9 * 255),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
                    ],
                  ),
                ).animate().fadeIn(duration: 1000.ms, delay: 600.ms).slideY(begin: 0.3),
                
                const SizedBox(height: 30),
                
                // Features
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1 * 255),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2 * 255),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Features',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 800.ms, delay: 1000.ms),
                      
                      const SizedBox(height: 16),
                      
                      _buildFeatureItem('🎨 Modern UI/UX Design', 'Glassmorphism effects & smooth animations'),
                      _buildFeatureItem('🔐 Secure Authentication', 'Supabase backend with JWT tokens'),
                      _buildFeatureItem('🎮 3D Interactive Elements', 'Spline 3D animation background'),
                      _buildFeatureItem('📱 Cross-Platform', 'Works on Android, iOS, Web & Desktop'),
                      _buildFeatureItem('⚡ Performance Optimized', 'Smooth 60fps animations'),
                    ],
                  ),
                ).animate().fadeIn(duration: 1000.ms, delay: 1000.ms).slideY(begin: 0.3),
                
                const SizedBox(height: 30),
                
                // Developer Info
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1 * 255),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2 * 255),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Developer',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 800.ms, delay: 1200.ms),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'Afdhal',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 800.ms, delay: 1400.ms),
                      
                      Text(
                        'Full-Stack Web & App Developer\nSoftware Developer\nPenulis Teknis & Akademik',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8 * 255),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 800.ms, delay: 1600.ms),
                      
                      const SizedBox(height: 20),
                      
                      // Social Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialButton(
                            icon: Icons.web,
                            label: 'Blog',
                            onTap: () => _launchURL('https://dhallafdhal.blogspot.com/'),
                          ),
                          _buildSocialButton(
                            icon: Icons.code,
                            label: 'GitHub',
                            onTap: () => _launchURL('https://github.com/dhall-afdhal'),
                          ),
                        ],
                      ).animate().fadeIn(duration: 800.ms, delay: 1800.ms),
                    ],
                  ),
                ).animate().fadeIn(duration: 1000.ms, delay: 1200.ms).slideY(begin: 0.3),
                
                const SizedBox(height: 30),
                
                // Copyright
                Text(
                  '© 2020 - 2025 𝘈𝘧𝘥𝘩𝘢𝘭 & 𝘋𝘏𝘈 𝘗𝘳𝘰𝘥𝘶𝘤𝘵𝘪𝘰𝘯',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6 * 255),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 800.ms, delay: 2000.ms),
                
                Text(
                  'All rights reserved',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6 * 255),
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 800.ms, delay: 2200.ms),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.7 * 255),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1 * 255),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2 * 255),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
