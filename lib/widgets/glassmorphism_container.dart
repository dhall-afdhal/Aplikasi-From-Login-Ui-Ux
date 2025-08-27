import 'package:flutter/material.dart';
import 'dart:ui';

class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.2,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1.5,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: opacity * 255),
              borderRadius: borderRadius ?? BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
