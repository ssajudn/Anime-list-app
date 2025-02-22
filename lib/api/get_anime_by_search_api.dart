import 'dart:convert';

import 'package:anime_list/config/app_config.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/models/anime_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getAnimeBySearch({required String query}) async {
  final baseUrl = "https://api.myanimelist.net/v2/anime?q=$query&limit=10";

  final res = await http
      .get(Uri.parse(baseUrl), headers: {"X-MAL-CLIENT-ID": clientId});

  if (res.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(res.body);
    AnimeInfo animeInfo = AnimeInfo.fromJson(data);
    Iterable<Anime> animes = animeInfo.animes;

    return animes;
  } else {
    debugPrint("Error: ${res.statusCode}");
    debugPrint("Body: ${res.body}");

    throw Exception("Failed to fetch anime data.");
  }
}
