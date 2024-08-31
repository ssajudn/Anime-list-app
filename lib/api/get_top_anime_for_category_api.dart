import 'dart:convert';

import 'package:anime_list/config/app_config.dart';
import 'package:anime_list/models/anime_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> getCategoryPicture({
  required String category,
}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$category&limit=1';

  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': clientId,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final animes = AnimeInfo.fromJson(data);
    final mainPicture = animes.animes.first.node.mainPicture.large;

    return mainPicture;
  } else {
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");
    throw Exception("Failed to get data!");
  }
}