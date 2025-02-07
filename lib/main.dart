import 'package:flutter/material.dart';

import 'flashcards_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const ChineseFlashcardsApp());
}

class ChineseFlashcardsApp extends StatelessWidget {
  const ChineseFlashcardsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chinese Flashcards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ChineseFlashcardsHomePage(),
    );
  }
}

class ChineseFlashcardsHomePage extends StatefulWidget {
  const ChineseFlashcardsHomePage({super.key});

  @override
  State<ChineseFlashcardsHomePage> createState() => _ChineseFlashcardsHomePageState();
}

class _ChineseFlashcardsHomePageState extends State<ChineseFlashcardsHomePage> {
  int _currentTab = 0;
  final List<Widget> _pages = <Widget>[
    const FlashcardsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentTab),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            key: Key('home'),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            key: Key('settings'),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentTab,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
    );
  }
}
