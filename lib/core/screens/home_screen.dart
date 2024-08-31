import 'package:anime_list/core/screens/anime_screen.dart';
import 'package:anime_list/core/screens/categories_screen.dart';
import 'package:anime_list/core/screens/search_screen.dart';
import 'package:anime_list/core/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.index});
  final int? index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    super.initState();
  }

  final _destinations = [
    const NavigationDestination(icon: Icon(Icons.home), label: "Home"),
    const NavigationDestination(icon: Icon(Icons.search), label: "Search"),
    const NavigationDestination(
        icon: Icon(Icons.category), label: "Categories"),
    const NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
  ];

  final _screens = const [
    AnimeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        elevation: 12,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        destinations: _destinations,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
