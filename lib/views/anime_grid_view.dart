import 'package:anime_list/api/get_anime_by_rankinf_type.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/models/anime_category.dart';
import 'package:anime_list/views/anime_grid_list.dart';
import 'package:flutter/material.dart';

class AnimeGridView extends StatelessWidget {
  const AnimeGridView({super.key, required this.category});

  final AnimeCategory category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          getAnimeByRankingType(rankingType: category.rankingType, limit: 100),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final animes = snapshot.data;

          return AnimeGridList(
            title: category.title,
            animes: animes!,
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
