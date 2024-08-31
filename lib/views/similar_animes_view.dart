import 'package:anime_list/core/screens/anime_details_screen.dart';
import 'package:anime_list/models/anime_node.dart';
import 'package:anime_list/widgets/anime_tile.dart';
import 'package:flutter/material.dart';

class SimilarAnimesView extends StatelessWidget {
  const SimilarAnimesView(
      {super.key, required this.animes, required this.label});

  final List<AnimeNode> animes;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final anime = animes.elementAt(index);

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AnimeDetailsScreen(id: anime.id),
                    ),
                  );
                },
                child: AnimeTile(
                  anime: anime,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: animes.length,
          ),
        )
      ],
    );
  }
}
