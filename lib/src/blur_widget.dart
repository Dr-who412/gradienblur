// lib/src/blur_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that applies a blur effect to the area behind it.
///
/// This is a performant wrapper around [BackdropFilter]. It includes a
/// [RepaintBoundary] to isolate the blur effect and will skip the blur
/// entirely if the blur values are zero, preventing unnecessary GPU work.
///
/// Note: Widgets that use [BackdropFilter] can be expensive. Prefer to use
/// this widget only when necessary and consider using a [RepaintBoundary]
/// above the content that will be blurred.
///
/// @see [BackdropFilter]
/// @see [ImageFilter.blur]
class BlurWidget extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The standard deviation of the Gaussian blur to apply in both directions.
  /// This value is used if [sigmaX] and [sigmaY] are null.
  /// Defaults to 10.0.
  final double? blur;

  /// The standard deviation of the Gaussian blur to apply in the horizontal direction.
  /// If provided, this overrides the [blur] value for the X-axis.
  final double? sigmaX;

  /// The standard deviation of the Gaussian blur to apply in the vertical direction.
  /// If provided, this overrides the [blur] value for the Y-axis.
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
    // 1. Calculate the final sigma values for clarity and reuse.
    final double finalSigmaX = sigmaX ?? blur ?? 10.0;
    final double finalSigmaY = sigmaY ?? blur ?? 10.0;

    // 2. Performance Optimization: If there's no blur, don't build the expensive
    // filter stack. Just return the child.
    if (finalSigmaX <= 0 && finalSigmaY <= 0) {
      return child;
    }

    // 3. If blur is needed, build the optimized filter stack.
    // RepaintBoundary is crucial for performance.
    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: finalSigmaX,
            sigmaY: finalSigmaY,
          ),
          child: child,
        ),
      ),
    );
  }
}
