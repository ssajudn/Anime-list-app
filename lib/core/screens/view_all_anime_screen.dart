import 'package:anime_list/api/get_anime_by_rankinf_type.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/views/ranked_anime_list_view.dart';
import 'package:flutter/material.dart';

class ViewAllAnimeScreen extends StatelessWidget {
  const ViewAllAnimeScreen({
    super.key,
    required this.rankingType,
    required this.label,
  });

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: FutureBuilder(
        future: getAnimeByRankingType(rankingType: rankingType, limit: 500),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (snapshot.data != null) {
            return RankedAnimeListView(
              animes: snapshot.data!,
            );
          }

          return ErrorScreen(error: snapshot.error.toString());
        },
      ),
    );
  }
}
