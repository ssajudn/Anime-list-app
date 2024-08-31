import 'dart:convert';

import 'package:anime_list/common/utils/utils.dart';
import 'package:anime_list/config/app_config.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/models/anime_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getSeasonalAnimes({
  required int limit,
}) async {
  final year = DateTime.now().year;
  final season = getCurrentSeason();
  final baseUrl =
      "https://api.myanimelist.net/v2/anime/season/$year/$season?limit=$limit";

  // Make a GET request
  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': clientId,
    },
  );

  if (response.statusCode == 200) {
    // Successful response
    final Map<String, dynamic> data = json.decode(response.body);
    final seasonalAnime = AnimeInfo.fromJson(data);

    return seasonalAnime.animes;
  } else {
    // Error handling
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");
    throw Exception("Failed to get data!");
  }
}
