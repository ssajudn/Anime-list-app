import 'dart:convert';

import 'package:anime_list/config/app_config.dart';
import 'package:anime_list/models/anime_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<AnimeDetails> getAnimeDetails({required int id}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';

  final res = await http
      .get(Uri.parse(baseUrl), headers: {"X-MAL-CLIENT-ID": clientId});

  if (res.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(res.body);
    final animeDetails = AnimeDetails.fromJson(data);

    return animeDetails;
  } else {
    debugPrint("Error: ${res.statusCode}");
    debugPrint("Body: ${res.body}");

    throw Exception("Failed to fetch anime data.");
  }
}
