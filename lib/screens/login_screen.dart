import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
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
                  const SizedBox(height: 40),
                  
                  // Title Section
                  Text(
                    'Login.',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Welcome Back,',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3),
                  
                  Text(
                    'Sign in to continue',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8 * 255),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideX(begin: -0.3),
                  
                  const SizedBox(height: 60),
                  
                  // Form Section
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.3),
                        
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
                        ).animate().fadeIn(duration: 800.ms, delay: 800.ms).slideY(begin: 0.3),
                        
                        const SizedBox(height: 16),
                        
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Forgot password feature coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8 * 255),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms, delay: 1000.ms).slideY(begin: 0.3),
                        
                        const SizedBox(height: 40),
                        
                        // Login Button
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
                              onTap: _isLoading ? null : _login,
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
                                        'Login',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms, delay: 1200.ms).slideY(begin: 0.3),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Sign Up Link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'New User? Sign Up',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.8 * 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 1400.ms).slideY(begin: 0.3),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
