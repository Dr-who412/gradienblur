GradienBlur

[//]: # (![alt text]&#40;https://img.shields.io/pub/v/gradienblur.svg&#41;)

[//]: # ()
[//]: # (![alt text]&#40;https://img.shields.io/pub/points/gradienblur&#41;)

[//]: # ()
[//]: # (![alt text]&#40;https://img.shields.io/badge/license-MIT-blue.svg&#41;)
A highly performant and customizable Flutter widget that creates a beautiful, soft gradient blur effect. Perfect for headers, overlays, and modern UI designs.
This package creates its effect by intelligently stacking multiple blur layers, giving you fine-grained control over performance and visual quality.
<br>

[//]: # (![alt text]&#40;https://github.com/Dr-who/gradienblur/raw/main/demo.gif&#41;)
Note: You need to create this demo.gif and upload it to your GitHub repository for it to show up. You can use a tool like ScreenToGif or Kap to record your example app.
Features
Beautiful Soft Blur: Creates a smooth, natural transition from clear to blurry.
Highly Customizable: Control the blur intensity, direction, smoothness, and performance.
Color Gradient Overlay: Easily add a color tint (like a dark fade) on top of the blur.
Great Performance: You control the number of layers (slices) to balance quality vs. performance.
Simple API: Easy to use and integrate into any project.
Pure Dart & Flutter: Works everywhere Flutter does.
Getting Started
1. Installation
   Add gradienblur to your pubspec.yaml file:
   code
   Yaml
   dependencies:
   gradienblur: ^1.0.1 # Use the latest version
   Then, run flutter pub get in your terminal.
2. Import
   Import the package in the Dart file where you want to use it:
   code
   Dart
   import 'package:gradienblur/gradienblur.dart';
   Basic Usage
   The most common use case is to place GradienBlur in a Stack over an image or other content.
   code
   Dart
   import 'package:flutter/material.dart';
   import 'package:gradienblur/gradienblur.dart';

class MyScreen extends StatelessWidget {
const MyScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
body: Stack(
children: [
// Your background content (e.g., an image)
Image.network(
'https://images.unsplash.com/photo-1576085898323-218337e3e43c',
fit: BoxFit.cover,
height: double.infinity,
width: double.infinity,
),

          // The GradienBlur widget
          const GradienBlur(
            maxBlur: 10.0,
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: kToolbarHeight),
                child: Text(
                  'Page Title',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
}
Customization & API Reference
You can customize the appearance and performance of GradienBlur with these properties:
Parameter	Type	Description	Default Value
child	Widget	Required. The content to display on top of the blur effect.	-
maxBlur	double	The maximum blur sigma value at the most blurry end of the gradient.	20.0
minBlur	double	The minimum blur sigma value at the least blurry end of the gradient.	0.0
slices	int	The number of layers used to create the effect. Higher values are smoother but less performant.	20
gradient	LinearGradient?	An optional color gradient to overlay on top of the blur.	null
direction	GradientBlurDirection	The direction of the blur gradient (e.g., topToBottom, leftToRight).	GradientBlurDirection.topToBottom
curve	Curve	The easing curve for the blur transition. Use Curves.easeInOut for a very soft, natural look.	Curves.linear
edgeBlur	double?	An optional, subtle blur applied over the entire effect to soften the edges between slices, making the gradient even smoother.	null
Example with Soft Curve
For an exceptionally soft and smooth effect, use the curve and edgeBlur properties.
code
Dart
GradienBlur(
maxBlur: 15.0,
minBlur: 0.0,
// Use a curve for a more natural transition
curve: Curves.easeInOut,
// Add a subtle blur to smooth the slice edges
edgeBlur: 1.0,
child: YourContent(),
)
Issues and Contributions
Feel free to file an issue on the GitHub repository if you find a bug or have a feature request.
Contributions are welcome!
License
This package is licensed under the MIT License. See the LICENSE file for more details.