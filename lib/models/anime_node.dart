import 'package:anime_list/models/picture.dart';
import 'package:flutter/material.dart';

@immutable
class AnimeNode {
  final int id;
  final String title;
  final Picture mainPicture;

  const AnimeNode(
      {required this.id, required this.title, required this.mainPicture});

  factory AnimeNode.fromJson(Map<String, dynamic> json) {
    return AnimeNode(
      id: json['id'],
      title: json['title'],
      mainPicture: Picture.fromJson(json['main_picture']),
    );
  }
}
