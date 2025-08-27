# 🚀 Modern Flutter Login App with 3D Animation

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2.0-blue?style=for-the-badge&logo=dart)
![Supabase](https://img.shields.io/badge/Supabase-2.8.0-green?style=for-the-badge&logo=supabase)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

**A modern, beautiful Flutter application featuring 3D animations, glassmorphism design, and Supabase backend integration.**

[![Demo](https://img.shields.io/badge/Demo-Live-orange?style=for-the-badge)](https://dhallafdhal.blogspot.com/)
[![Documentation](https://img.shields.io/badge/Docs-Read-blue?style=for-the-badge)](https://dhallafdhal.blogspot.com/)

</div>

---

## ✨ Features

### 🎨 **Modern UI/UX Design**
- **Glassmorphism Effects** - Beautiful transparent glass-like components
- **3D Spline Animation** - Interactive 3D background using Spline Viewer
- **Gradient Backgrounds** - Stunning color transitions
- **Smooth Animations** - Flutter Animate for fluid transitions
- **Responsive Design** - Works perfectly on all screen sizes

### 🔐 **Authentication System**
- **Supabase Backend** - Secure authentication with Supabase
- **Email & Password Login** - Traditional authentication
- **User Registration** - Complete signup flow
- **Form Validation** - Real-time input validation
- **Secure Storage** - Flutter Secure Storage for sensitive data

### 🎮 **Interactive 3D Elements**
- **Spline 3D Animation** - Background 3D scene
- **Touch Interactions** - Drag to rotate, pinch to zoom
- **WebView Integration** - Seamless 3D content embedding
- **Performance Optimized** - Smooth 60fps animations

### 📱 **Cross-Platform Support**
- **Android** - Full native support
- **iOS** - Complete compatibility
- **Web** - Responsive web design
- **Desktop** - Windows, macOS, Linux

---

## 🛠️ Technology Stack

### **Frontend**
- **Flutter 3.16.0** - Cross-platform UI framework
- **Dart 3.2.0** - Programming language
- **Flutter Animate** - Animation library
- **Google Fonts** - Typography (Poppins)
- **WebView Flutter** - 3D content embedding

### **Backend & Services**
- **Supabase** - Backend-as-a-Service
- **PostgreSQL** - Database
- **Row Level Security** - Data protection
- **JWT Authentication** - Secure tokens

### **UI Components**
- **Glassmorphism** - Transparent effects
- **Custom Widgets** - Reusable components
- **Form Validation** - Input validation
- **Loading States** - User feedback

---

## 📱 Screenshots

<div align="center">

### Login Screen
![Login Screen](https://via.placeholder.com/300x600/667eea/ffffff?text=Login+Screen)

### Register Screen  
![Register Screen](https://via.placeholder.com/300x600/673ab7/ffffff?text=Register+Screen)

### Home Screen
![Home Screen](https://via.placeholder.com/300x600/9c27b0/ffffff?text=Home+Screen)

</div>

---

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK 3.16.0 or higher
- Dart 3.2.0 or higher
- Android Studio / VS Code
- Supabase account

### **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/dhall-afdhal/flutter-login-app.git
   cd flutter-login-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Supabase**
   - Create a new Supabase project
   - Run the SQL setup script in `supabase_simple_setup.sql`
   - Update your Supabase credentials in `lib/services/supabase_config.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📋 Database Setup

### **Supabase Configuration**

1. **Create Database Tables**
   ```sql
   -- Run this in Supabase SQL Editor
   CREATE TABLE IF NOT EXISTS public.profiles (
     id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
     full_name TEXT,
     avatar_url TEXT,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
     updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

2. **Enable Row Level Security**
   ```sql
   ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
   ```

3. **Create Security Policies**
   ```sql
   CREATE POLICY "Users can view own profile" ON public.profiles
     FOR SELECT USING (auth.uid() = id);
   ```

### **Environment Variables**
Create a `.env` file in the root directory:
```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── login_screen.dart     # Login screen
│   ├── register_screen.dart  # Register screen
│   └── home_screen.dart      # Home screen
├── services/                 # Business logic
│   ├── auth_service.dart     # Authentication service
│   └── supabase_config.dart  # Supabase configuration
├── widgets/                  # Reusable components
│   ├── custom_button.dart    # Custom button widget
│   ├── custom_text_field.dart # Custom text field
│   └── glassmorphism_container.dart # Glassmorphism container
└── models/                   # Data models
    └── user_model.dart       # User data model
```

---

## 🎨 Customization

### **Colors & Themes**
```dart
// Update colors in lib/main.dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF667eea),
  brightness: Brightness.dark,
),
```

### **3D Animation**
```html
<!-- Update Spline URL in screens -->
<spline-viewer url="your_spline_url"></spline-viewer>
```

### **Fonts**
```yaml
# Update in pubspec.yaml
fonts:
  - family: Poppins
    fonts:
      - asset: assets/fonts/Poppins-Regular.ttf
```

---

## 🔧 Configuration

### **Supabase Setup**
1. Create a new Supabase project
2. Get your project URL and anon key
3. Update `lib/services/supabase_config.dart`
4. Run the database setup script

### **3D Animation**
1. Create a Spline 3D scene
2. Export as `.splinecode`
3. Update the URL in both login and register screens

### **Build Configuration**
```yaml
# android/app/build.gradle.kts
android {
    compileSdk = 34
    ndkVersion = "27.0.12077973"
}
```

---

## 📦 Dependencies

### **Core Dependencies**
```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^2.8.0
  webview_flutter: ^4.7.0
  flutter_animate: ^4.5.0
  google_fonts: ^6.2.1
  flutter_secure_storage: ^9.2.2
  provider: ^6.1.2
```

### **Dev Dependencies**
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## 🚀 Deployment

### **Android APK**
```bash
flutter build apk --release
```

### **iOS App Store**
```bash
flutter build ios --release
```

### **Web Deployment**
```bash
flutter build web --release
```

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

<div align="center">

### **Afdhal**
**Full-Stack Web & App Developer | Software Developer | Penulis Teknis & Akademik**

[![Blog](https://img.shields.io/badge/Blog-DHAL%20Afdhal-orange?style=for-the-badge)](https://dhallafdhal.blogspot.com/)
[![GitHub](https://img.shields.io/badge/GitHub-dhall--afdhal-blue?style=for-the-badge&logo=github)](https://github.com/dhall-afdhal)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Afdhal-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/afdhal)

**© 2020 - 2025 𝘈𝘧𝘥𝘩𝘢𝘭 & 𝘋𝘏𝘈 𝘗𝘳𝘰𝘥𝘶𝘤𝘵𝘪𝘰𝘯 — All rights reserved**

</div>

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **Supabase** - For the backend services
- **Spline** - For 3D animation tools
- **Google Fonts** - For beautiful typography
- **Flutter Community** - For excellent packages

---

## 📞 Support

If you have any questions or need help:

- **Email**: [Contact via Blog](https://dhallafdhal.blogspot.com/)
- **GitHub Issues**: [Create an issue](https://github.com/dhall-afdhal/flutter-login-app/issues)
- **Documentation**: [Read the docs](https://dhallafdhal.blogspot.com/)

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

**Made with ❤️ by Afdhal**

</div>
