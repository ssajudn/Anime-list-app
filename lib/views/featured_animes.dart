import 'package:anime_list/api/get_anime_by_rankinf_type.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/screens/view_all_anime_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/widgets/anime_tile.dart';
import 'package:flutter/material.dart';

class FeaturedAnimes extends StatelessWidget {
  const FeaturedAnimes(
      {super.key, required this.rankingType, required this.label});

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeByRankingType(rankingType: rankingType, limit: 10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (snapshot.data != null) {
            final animes = snapshot.data;

            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ViewAllAnimeScreen(
                                  rankingType: rankingType, label: label),
                            ),
                          );
                        },
                        child: const Text("View all"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final anime = animes.elementAt(index);

                      return AnimeTile(
                        anime: anime.node,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: animes!.length,
                  ),
                )
              ],
            );
          }

          return ErrorScreen(error: snapshot.error.toString());
        });
  }
}
