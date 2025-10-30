import 'package:flutter/material.dart';
import 'package:gradient_blur/gradient_blur.dart';
import 'package:webview_flutter/webview_flutter.dart';


// Main function to run the app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradienBlur Example',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C1C1E),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// --- 1. The Home Page with navigation buttons ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GradientBlur Examples'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImageExampleScreen(),
                ));
              },
              child: const Text('Example over an Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WebViewExampleScreen(),
                ));
              },
              child: const Text('Example over a WebView (iOS/Android)'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. The Original Example: Blur over an Image ---
class ImageExampleScreen extends StatelessWidget {
  const ImageExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.network(
            'https://images.unsplash.com/photo-1576085898323-218337e3e43c',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          // GradienBlur widget
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientBlur(
              maxBlur: 8.0,
              minBlur: 0.0,
              slices: 30,
              curve: Curves.easeInOut,
              edgeBlur: null,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.7],
              ),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Text(
                        'Image Example',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

// --- 3. The New Example: Blur over a WebView ---
class WebViewExampleScreen extends StatefulWidget {
  const WebViewExampleScreen({super.key});

  @override
  State<WebViewExampleScreen> createState() => _WebViewExampleScreenState();
}

class _WebViewExampleScreenState extends State<WebViewExampleScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WebView Widget (bottom layer)
          WebViewWidget(controller: _controller),

          // Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          // GradientBlur widget (top layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientBlur(
              maxBlur: 15.0,
              minBlur: 0.0,
              slices: 30,
              curve: Curves.easeInOut,
              edgeBlur: null,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.8],
              ),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Text(
                        'WebView Example',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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