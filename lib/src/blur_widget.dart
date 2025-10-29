// lib/src/blur_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that applies a blur effect to the area behind it.
///
/// This is a simple wrapper around [BackdropFilter] with an [ImageFilter.blur].
class BlurWidget extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The standard deviation of the Gaussian blur to apply in both directions.
  /// If [sigmaX] and [sigmaY] are null, this value is used.
  /// Defaults to 10.0.
  final double? blur;

  /// The standard deviation of the Gaussian blur to apply in the horizontal direction.
  final double? sigmaX;

  /// The standard deviation of the Gaussian blur to apply in the vertical direction.
  final double? sigmaY;

  /// Creates a widget that applies a blur effect.
  const BlurWidget({
    super.key,
    required this.child,
    this.blur,
    this.sigmaX,
    this.sigmaY,
  });

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary is used to optimize performance by isolating the repaint
    // of the blur effect from the rest of the widget tree.
    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigmaX ?? blur ?? 10.0,
            sigmaY: sigmaY ?? blur ?? 10.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
