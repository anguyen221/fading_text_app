import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  Color _textColor = Colors.black;
  bool _showFrame = false;
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

  void pickColor() {
    Color tempColor = _textColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (color) {
              tempColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              setState(() {
                _textColor = tempColor;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
            IconButton(
              icon: const Icon(Icons.palette),
              onPressed: pickColor,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: toggleVisibility,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Text(
                        'Hello, Flutter!',
                        style: TextStyle(fontSize: 24, color: _textColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: _showFrame
                          ? Border.all(
                              color: Colors.blue,
                              width: 5,
                            )
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('Show Frame'),
                    value: _showFrame,
                    onChanged: (bool value) {
                      setState(() {
                        _showFrame = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: Text(
                  'Hello, Flutter (Again)!',
                  style: TextStyle(fontSize: 24, color: _textColor),
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
