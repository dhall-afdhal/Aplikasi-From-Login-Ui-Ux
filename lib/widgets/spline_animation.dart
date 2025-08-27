import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplineAnimation extends StatefulWidget {
  const SplineAnimation({super.key});

  @override
  State<SplineAnimation> createState() => _SplineAnimationState();
}

class _SplineAnimationState extends State<SplineAnimation> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://community.spline.design/file/6c2b6a7a-3dee-4883-a590-aac7c8d737b5'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1 * 255),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3 * 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
