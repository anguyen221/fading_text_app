import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const FadingTextScreen(),
    );
  }
}

class FadingTextScreen extends StatefulWidget {
  const FadingTextScreen({super.key});

  @override
  _FadingTextScreenState createState() => _FadingTextScreenState();
}

class _FadingTextScreenState extends State<FadingTextScreen> {
  bool _isVisible = true;
  bool _isDarkMode = false;
  PageController _pageController = PageController();

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fading Text App'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: const Text(
                  'Hello, Flutter (Again)!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
