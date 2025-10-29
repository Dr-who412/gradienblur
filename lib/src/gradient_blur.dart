// lib/src/gradient_blur.dart

import 'dart:ui'; // Required for lerpDouble and ImageFilter
import 'package:flutter/material.dart';
import 'blur_widget.dart';

/// An enum to define the direction of the blur gradient.
enum GradientBlurDirection {
  topToBottom,
  bottomToTop,
  leftToRight,
  rightToLeft,
}

/// A widget that creates a beautiful gradient blur effect by stacking multiple
/// blur layers.
///
/// This widget provides high control over the visual quality and performance,
/// allowing for a soft, natural blur transition.
class GradientBlur extends StatelessWidget {
  /// The widget to display on top of the gradient blur effect.
  final Widget child;

  /// The maximum blur sigma value at the most blurry end of the gradient.
  /// Defaults to 20.0.
  final double maxBlur;

  /// The minimum blur sigma value at the least blurry end of the gradient.
  /// Defaults to 0.0.
  final double minBlur;

  /// The number of slices used to create the gradient effect.
  ///
  /// A higher number creates a smoother gradient but may impact performance.
  /// A lower number is more performant but may show visible "banding".
  /// For a soft look, values between 15 and 30 are usually sufficient.
  /// Defaults to 20.
  final int slices;

  /// A `LinearGradient` to overlay on top of the blur effect for color tinting.
  final LinearGradient? gradient;

  /// The direction of the blur gradient.
  /// Defaults to [GradientBlurDirection.topToBottom].
  final GradientBlurDirection direction;

  /// The easing curve for the blur transition.
  ///
  /// Using a non-linear curve like [Curves.easeInOut] can create a much
  /// softer and more natural-looking gradient.
  /// Defaults to [Curves.linear].
  final Curve curve;

  /// An optional, subtle blur applied to the edges between the blur slices
  /// to make the entire gradient even softer.
  ///
  /// A small value like 0.5 or 1.0 is recommended. If null, no edge blur is applied.
  /// Defaults to null.
  final double? edgeBlur;

  /// Creates a widget that applies a gradient blur effect.
  const GradientBlur({
    super.key,
    required this.child,
    this.maxBlur = 20.0,
    this.minBlur = 0.0,
    this.slices = 20,
    this.gradient,
    this.direction = GradientBlurDirection.topToBottom,
    this.curve = Curves.linear,
    this.edgeBlur,
  });

  @override
  Widget build(BuildContext context) {
    // We build the blur layers first
    Widget blurStack = _buildBlurLayers();

    // If edgeBlur is specified, we wrap the entire stack in one more filter
    if (edgeBlur != null && edgeBlur! > 0) {
      blurStack = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: edgeBlur!, sigmaY: edgeBlur!),
        child: blurStack,
      );
    }

    return ClipRect(
      child: Stack(
        children: [
          // 1. The Optional Gradient Overlay
          if (gradient != null)
            Container(
              decoration: BoxDecoration(gradient: gradient),
            ),
          // 2. The Gradient Blur Layer
          blurStack,
          // 3. The Child Content
          child,
        ],
      ),
    );
  }

  /// Builds the stack of blur widgets to create the gradient effect.
  Widget _buildBlurLayers() {
    final isReversed = direction == GradientBlurDirection.bottomToTop ||
        direction == GradientBlurDirection.rightToLeft;
    final isVertical = direction == GradientBlurDirection.topToBottom ||
        direction == GradientBlurDirection.bottomToTop;

    List<Widget> blurSlices = [];
    for (int i = 0; i < slices; i++) {
      // Calculate the progress from 0.0 to 1.0
      final t = (slices > 1) ? i / (slices - 1) : 0.0;

      // Apply the curve to the progress value
      final curvedT = curve.transform(t);

      // Interpolate the blur amount between max and min blur using the curved progress
      // We use lerpDouble for a safe and clean interpolation.
      final double blurAmount = lerpDouble(
        isReversed ? minBlur : maxBlur,
        isReversed ? maxBlur : minBlur,
        curvedT,
      )!;

      blurSlices.add(
        Expanded(
          child: BlurWidget(
            blur: blurAmount.clamp(minBlur, maxBlur),
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
