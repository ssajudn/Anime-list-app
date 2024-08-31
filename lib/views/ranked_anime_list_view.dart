import 'package:anime_list/common/styles/paddings.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/widgets/ranked_anime_list_tile.dart';
import 'package:flutter/material.dart';

class RankedAnimeListView extends StatelessWidget {
  const RankedAnimeListView({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index);

          return RankedAnimeListTile(
            anime: anime,
          );
        },
        itemCount: animes.length,
      ),
    );
  }
}
