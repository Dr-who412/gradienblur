// lib/src/gradien_blur.dart

import 'package:flutter/material.dart';
import 'blur_widget.dart';

/// An enum to define the direction of the blur gradient.
enum GradientBlurDirection {
  /// Blur increases from top to bottom.
  topToBottom,

  /// Blur increases from bottom to top.
  bottomToTop,

  /// Blur increases from left to right.
  leftToRight,

  /// Blur increases from right to left.
  rightToLeft,
}

/// A widget that creates a beautiful gradient blur effect on the area behind it.
///
/// It works by stacking multiple layers of [BlurWidget] with increasing blur values,
/// creating a smooth transition from clear to blurry. An optional gradient overlay
/// can be applied on top.
class GradienBlur extends StatelessWidget {
  /// The widget to display on top of the gradient blur effect.
  final Widget child;

  /// The maximum blur sigma value at the most blurry end of the gradient.
  ///
  /// Defaults to 20.0.
  final double maxBlur;

  /// The minimum blur sigma value at the least blurry end of the gradient.
  ///
  /// Defaults to 0.0.
  final double minBlur;

  /// The number of slices used to create the gradient effect.
  ///
  /// A higher number creates a smoother gradient but may impact performance.
  /// A lower number is more performant but may show visible "banding".
  /// Defaults to 40.
  final int slices;

  /// A `LinearGradient` to overlay on top of the blur effect.
  ///
  /// This can be used to add a color tint, like a black fade, to the effect.
  /// If null, no gradient is applied.
  final LinearGradient? gradient;

  /// The direction of the blur gradient.
  ///
  /// For example, [GradientBlurDirection.topToBottom] means the top will be
  /// the most blurry and the bottom will be the clearest.
  /// Defaults to [GradientBlurDirection.topToBottom].
  final GradientBlurDirection direction;

  /// Creates a widget that applies a gradient blur effect.
  const GradienBlur({
    super.key,
    required this.child,
    this.maxBlur = 20.0,
    this.minBlur = 0.0,
    this.slices = 40,
    this.gradient,
    this.direction = GradientBlurDirection.topToBottom,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // 1. The Optional Gradient Overlay
          if (gradient != null)
            Container(decoration: BoxDecoration(gradient: gradient)),
          // 2. The Gradient Blur Layer
          _buildBlurLayers(),
          // 3. The Child Content
          child,
        ],
      ),
    );
  }

  /// Builds the stack of blur widgets to create the gradient effect.
  Widget _buildBlurLayers() {
    final blurStep = (maxBlur - minBlur).abs() / (slices > 1 ? slices - 1 : 1);
    final isReversed =
        direction == GradientBlurDirection.bottomToTop ||
        direction == GradientBlurDirection.rightToLeft;
    final isVertical =
        direction == GradientBlurDirection.topToBottom ||
        direction == GradientBlurDirection.bottomToTop;

    List<Widget> blurSlices = [];
    for (int i = 0; i < slices; i++) {
      final double blurAmount = isReversed
          ? minBlur + (i * blurStep)
          : maxBlur - (i * blurStep);

      blurSlices.add(
        Expanded(
          child: BlurWidget(
            blur: blurAmount.clamp(
              minBlur,
              maxBlur,
            ), // Ensure blur is within bounds
            child: const SizedBox.expand(),
          ),
        ),
      );
    }

    return Flex(
      direction: isVertical ? Axis.vertical : Axis.horizontal,
      children: blurSlices,
    );
  }
}
