import 'package:anime_list/common/styles/text_styles.dart';
import 'package:anime_list/core/screens/anime_details_screen.dart';
import 'package:anime_list/models/anime_node.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeTile extends StatelessWidget {
  const AnimeTile({super.key, required this.anime});

  final AnimeNode anime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(id: anime.id),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: anime.mainPicture.medium,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              anime.title,
              maxLines: 3,
              style: TextStyles.mediumText,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
