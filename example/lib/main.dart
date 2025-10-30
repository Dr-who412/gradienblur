// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:gradient_blur/gradient_blur.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradientBlur Example',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background Image
            Image.network(
              'https://wallpaperaccess.com/full/2833661.jpg',
              //height: MediaQuery.of(context).size.height/2,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            ),

            // Your Gradient Blur Widget
             SizedBox(
               height: MediaQuery.of(context).size.height,
               child: GradientBlur(
                 maxBlur: 10.0,
                 minBlur: 0.0,
                 edgeBlur: null,
                 slices: 120,
                 gradient: LinearGradient(
                   colors: [Colors.black87.withValues(alpha: .2), Colors.transparent],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   stops: [0.0, 0.5],
                 ),
                 child: Padding(
                   padding: EdgeInsets.only(
                     top: kToolbarHeight,
                     left: 20,
                     right: 20,
                     bottom: 20,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Icon(Icons.arrow_back, color: Colors.white),
                       Text(
                         'Profile',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 22,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       Icon(Icons.more_vert, color: Colors.white),
                     ],
                   ),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
