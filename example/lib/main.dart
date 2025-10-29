// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:gradienblur/gradienblur.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradienBlur Example',
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background Image
            Image.network(
              'https://wallpaperaccess.com/full/2833661.jpg',
              height: MediaQuery.of(context).size.height/2,
            ),

            // Your GradienBlur Widget
             Container(
               height: 240,
               child: GradienBlur(
                 maxBlur: 40.0,
                 minBlur: 0.0,
                 gradient: LinearGradient(
                   colors: [Colors.black87.withOpacity(.2), Colors.transparent],
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
