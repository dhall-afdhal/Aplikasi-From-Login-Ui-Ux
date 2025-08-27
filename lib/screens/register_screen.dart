import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late final WebViewController _splineController;

  @override
  void initState() {
    super.initState();
    _splineController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
          },
          onPageFinished: (String url) {
            print('Spline 3D animation loaded successfully');
          },
        ),
      )
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Spline 3D Animation</title>
          <style>
            body {
              margin: 0;
              padding: 0;
              background: transparent;
              overflow: hidden;
            }
            spline-viewer {
              width: 100vw;
              height: 100vh;
              background: transparent;
            }
          </style>
        </head>
        <body>
          <script type="module" src="https://unpkg.com/@splinetool/viewer@1.10.52/build/spline-viewer.js"></script>
          <spline-viewer url="https://prod.spline.design/a61dTE85FDsjTap0/scene.splinecode"></spline-viewer>
        </body>
        </html>
      ''');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _fullNameController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Registration successful! Please check your email to verify your account.'),
            backgroundColor: Colors.green.withValues(alpha: 0.8 * 255),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        
        Navigator.of(context).pop(); // Go back to login screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Colors.red.withValues(alpha: 0.8 * 255),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Spline 3D Animation Background
          SizedBox.expand(
            child: WebViewWidget(controller: _splineController),
          ),
          
          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE91E63), // Vibrant pink/magenta
                  Color(0xFF673AB7), // Deep purple
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Back Button
                  Container(
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
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
                  
                  const SizedBox(height: 40),
                  
                  // Title Section
                  Text(
                    'Sign Up.',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Create Account,',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3),
                  
                  Text(
                    'Join us and start your journey',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8 * 255),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideX(begin: -0.3),
                  
                  const SizedBox(height: 50),
                  
                  // Form Section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Full Name Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full Name',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.9 * 255),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _fullNameController,
                                    validator: _validateFullName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.3),
                            
                            const SizedBox(height: 30),
                            
                            // Email Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.9 * 255),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _validateEmail,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 800.ms, delay: 800.ms).slideY(begin: 0.3),
                            
                            const SizedBox(height: 30),
                            
                            // Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.9 * 255),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          validator: _validatePassword,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 800.ms, delay: 1000.ms).slideY(begin: 0.3),
                            
                            const SizedBox(height: 30),
                            
                            // Confirm Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Confirm Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.9 * 255),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _confirmPasswordController,
                                          obscureText: _obscureConfirmPassword,
                                          validator: _validateConfirmPassword,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword = !_obscureConfirmPassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 800.ms, delay: 1200.ms).slideY(begin: 0.3),
                            
                            const SizedBox(height: 40),
                            
                            // Create Account Button
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _isLoading ? null : _register,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Center(
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Text(
                                            'Create Account',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 1400.ms).slideY(begin: 0.3),
                            
                            const SizedBox(height: 30),
                            
                            // Sign In Link
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Already have an account? Sign In',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withValues(alpha: 0.8 * 255),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 1600.ms).slideY(begin: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
