import 'package:anime_list/common/styles/paddings.dart';
import 'package:anime_list/core/screens/search_screen.dart';
import 'package:anime_list/views/featured_animes.dart';
import 'package:anime_list/widgets/top_anime.dart';
import 'package:flutter/material.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Featured animes (5)
            SizedBox(
              height: 300,
              child: TopAnimeList(),
            ),
            // Top animes
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: "Top Ranked",
                      rankingType: "all",
                    ),
                  ),
                ],
              ),
            ),
            // Top popular
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: "Top Anime by Popularity",
                      rankingType: "bypopularity",
                    ),
                  ),
                ],
              ),
            ),
            // Top anime movies
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: "Top Anime Movies",
                      rankingType: "movie",
                    ),
                  ),
                ],
              ),
            ),
            // Top favorite
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: "Most Favorite",
                      rankingType: "favorite",
                    ),
                  ),
                ],
              ),
            ),
            // Top upcoming
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: FeaturedAnimes(
                      label: "Upcoming Animes",
                      rankingType: "upcoming",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
