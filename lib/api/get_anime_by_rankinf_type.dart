import 'dart:convert';

import 'package:anime_list/config/app_config.dart';
import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getAnimeByRankingType(
    {required String rankingType, required int limit}) async {
  final baseUrl =
      "https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit";

  final res = await http
      .get(Uri.parse(baseUrl), headers: {"X-MAL-CLIENT-ID": clientId});

  if (res.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(res.body);
    final List<dynamic> animeNodeList = data["data"];
    final animes = animeNodeList
        .where((animeNode) => animeNode["node"]["main_picture"] != null)
        .map((node) => Anime.fromJson(node));

    return animes;
  } else {
    debugPrint("Error: ${res.statusCode}");
    debugPrint("Body: ${res.body}");

    throw Exception("Failed to fetch anime data.");
  }
}
