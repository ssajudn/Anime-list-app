import 'package:anime_list/api/get_anime_details_api.dart';
import 'package:anime_list/common/extensions/extensions.dart';
import 'package:anime_list/common/styles/paddings.dart';
import 'package:anime_list/common/styles/text_styles.dart';
import 'package:anime_list/common/widgets/ios_back_button.dart';
import 'package:anime_list/common/widgets/network_image_view.dart';
import 'package:anime_list/common/widgets/read_more_text.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/cubits/anime_title_language_cubit.dart';
import 'package:anime_list/models/anime_details.dart';
import 'package:anime_list/models/picture.dart';
import 'package:anime_list/views/similar_animes_view.dart';
import 'package:anime_list/widgets/info_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeDetails(id: id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final anime = snapshot.data;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top image
                  _buildAnimeImageWidget(imageUrl: anime!.mainPicture.large),

                  Padding(
                    padding: Paddings.defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        _buildAnimeTitle(
                          name: anime.title,
                          englishName: anime.alternativeTitles.en,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Description
                        ReadMoreText(longText: anime.synopsis),

                        const SizedBox(
                          height: 10,
                        ),

                        // Anime info
                        _buildAnimeInfo(anime: anime),

                        const SizedBox(
                          height: 10,
                        ),

                        // Anime bg
                        anime.background.isNotEmpty
                            ? _buildAnimeBackground(
                                background: anime.background)
                            : const SizedBox.shrink(),

                        const SizedBox(
                          height: 10,
                        ),

                        // Img gallery
                        _buildImageGallery(images: anime.pictures),

                        const SizedBox(
                          height: 50,
                        ),

                        // Similar anime
                        SimilarAnimesView(
                          animes: anime.relatedAnime
                              .map((animeRel) => animeRel.node)
                              .toList(),
                          label: "Related Anime",
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Similar anime
                        SimilarAnimesView(
                          animes: anime.recommendations
                              .map((animeRec) => animeRec.node)
                              .toList(),
                          label: "Anime Recommendations",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }

  _buildAnimeImageWidget({
    required String imageUrl,
  }) =>
      Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 600,
            width: double.infinity,
          ),
          Positioned(
            top: 30,
            left: 20,
            child: Builder(builder: (context) {
              return IosBackButton(
                onPressed: Navigator.of(context).pop,
              );
            }),
          ),
        ],
      );

  Widget _buildAnimeTitle({
    required String name,
    required String englishName,
  }) =>
      BlocBuilder<AnimeTitleLanguageCubit, bool>(
        builder: (context, state) {
          bool isEnglish = state;
          return Text(
            isEnglish ? englishName : name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          );
        },
      );

  Widget _buildAnimeInfo({
    required AnimeDetails anime,
  }) {
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otherNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres: ', info: genres),
        InfoText(label: 'Start date: ', info: anime.startDate),
        InfoText(label: 'End date: ', info: anime.endDate),
        InfoText(label: 'Episodes: ', info: anime.numEpisodes.toString()),
        InfoText(
          label: 'Average Episode Duration: ',
          info: anime.averageEpisodeDuration.toMinute(),
        ),
        InfoText(label: 'Status: ', info: anime.status),
        InfoText(label: 'Rating: ', info: anime.rating),
        InfoText(label: 'Studios: ', info: studios),
        InfoText(label: 'Other Names: ', info: otherNames),
        InfoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InfoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBackground({
    required String background,
  }) {
    return WhiteContainer(
      child: Text(
        background,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildImageGallery({
    required List<Picture> images,
  }) {
    return Column(
      children: [
        const Text(
          "Image Gallery",
          style: TextStyles.mediumText,
        ),
        const SizedBox(
          height: 5,
        ),
        GridView.builder(
          itemBuilder: (context, index) {
            final image = images.elementAt(index);

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NetworkImageView(imageUrl: image.large),
                    ),
                  );
                },
                child: Image.network(
                  image.medium,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
        )
      ],
    );
  }
}

class WhiteContainer extends StatelessWidget {
  const WhiteContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
