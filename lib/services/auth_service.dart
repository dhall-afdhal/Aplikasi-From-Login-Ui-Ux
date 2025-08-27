import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'supabase_config.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  
  // Sign up with email and password
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        },
      );
      
      if (response.user != null) {
        // Store user data locally
        await _storage.write(key: 'user_id', value: response.user!.id);
        await _storage.write(key: 'user_email', value: response.user!.email);
        await _storage.write(key: 'user_full_name', value: fullName);
        
        // Create profile in database
        try {
          await SupabaseConfig.client
              .from('profiles')
              .insert({
                'id': response.user!.id,
                'full_name': fullName,
                'created_at': DateTime.now().toIso8601String(),
                'updated_at': DateTime.now().toIso8601String(),
              });
        } catch (profileError) {
          print('Profile creation error: $profileError');
          // Don't throw error here as user is already created
        }
      }
      
      return response;
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  // Sign in with email and password
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseConfig.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        await _storage.write(key: 'user_id', value: response.user!.id);
        await _storage.write(key: 'user_email', value: response.user!.email);
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await SupabaseConfig.client.auth.signOut();
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return SupabaseConfig.client.auth.currentUser;
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return getCurrentUser() != null;
  }

  // Get user profile
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = getCurrentUser();
      if (user == null) return null;

      final response = await SupabaseConfig.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      
      return response;
    } catch (e) {
      return null;
    }
  }

  // Update user profile
  static Future<void> updateUserProfile({
    required String fullName,
    String? avatarUrl,
  }) async {
    try {
      final user = getCurrentUser();
      if (user == null) return;

      await SupabaseConfig.client
          .from('profiles')
          .upsert({
            'id': user.id,
            'full_name': fullName,
            'avatar_url': avatarUrl,
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      rethrow;
    }
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await SupabaseConfig.client.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }
}
