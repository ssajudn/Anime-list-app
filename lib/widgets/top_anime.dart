import 'package:anime_list/api/get_anime_by_rankinf_type.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/widgets/top_animes_image_slider.dart';
import 'package:flutter/material.dart';

class TopAnimeList extends StatelessWidget {
  const TopAnimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeByRankingType(rankingType: "all", limit: 5),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final animes = snapshot.data!.toList();
          return TopAnimesImageSlider(
            animes: animes,
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
