import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glassmorphism_container.dart';
import '../widgets/custom_button.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await AuthService.getUserProfile();
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    try {
      await AuthService.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign out failed: ${e.toString()}'),
            backgroundColor: Colors.red.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.getCurrentUser();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667eea),
              const Color(0xFF764ba2),
              const Color(0xFFf093fb),
              const Color(0xFFf5576c),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),
                    
                    IconButton(
                      onPressed: _signOut,
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 24,
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.3),
                  ],
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // User Profile Card
                      GlassmorphismContainer(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 20),
                                  
                                  Text(
                                    _userProfile?['full_name'] ?? user?.email ?? 'User',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  
                                  Text(
                                    user?.email ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 20),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildStatCard('Posts', '12'),
                                      _buildStatCard('Followers', '1.2K'),
                                      _buildStatCard('Following', '890'),
                                    ],
                                  ),
                                ],
                              ),
                      ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.3),
                      
                      const SizedBox(height: 30),
                      
                      // Features Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: [
                          _buildFeatureCard(
                            'Profile',
                            Icons.person,
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile feature coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            'Settings',
                            Icons.settings,
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings feature coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            'Messages',
                            Icons.message,
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Messages feature coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            'Analytics',
                            Icons.analytics,
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Analytics feature coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ],
                      ).animate().fadeIn(duration: 1200.ms, delay: 200.ms).slideY(begin: 0.3),
                      
                      const SizedBox(height: 30),
                      
                      // Quick Actions
                      GlassmorphismContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Actions',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            CustomButton(
                              text: 'Edit Profile',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Edit profile feature coming soon!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: Icons.edit,
                            ),
                            
                            const SizedBox(height: 15),
                            
                            CustomButton(
                              text: 'Change Password',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Change password feature coming soon!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: Icons.lock,
                            ),
                            
                            const SizedBox(height: 15),
                            
                            CustomButton(
                              text: 'About App',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AboutScreen(),
                                  ),
                                );
                              },
                              icon: Icons.info_outline,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 1400.ms, delay: 400.ms).slideY(begin: 0.3),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, VoidCallback onTap) {
    return GlassmorphismContainer(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
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
