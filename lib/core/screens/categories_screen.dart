import 'package:anime_list/models/anime_category.dart';
import 'package:anime_list/views/anime_grid_view.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _animeTabs = animeCategories
      .map((category) => Tab(
            text: category.title,
          ))
      .toList();

  final _screens = animeCategories
      .map(
        (category) => AnimeGridView(
          category: category,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Anime Categories"),
          bottom: TabBar(
            tabs: _animeTabs,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorColor: Colors.red,
            labelColor: Colors.red,
          ),
        ),
        body: TabBarView(children: _screens),
      ),
    );
  }
}
