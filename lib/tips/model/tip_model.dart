// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class TipsVideoModel {
  final int position;
  final String title;
  final String link;
  final String source;
  final String date;
  final String thumbnail;
  final String snippet;
  final String length;
  final String image2;
  TipsVideoModel({
    required this.position,
    required this.title,
    required this.link,
    required this.source,
    required this.date,
    required this.thumbnail,
    required this.snippet,
    required this.length,
    required this.image2,
  });

  Image? getThumbnailImage() {
    // Split the data URL to get the base64 string
    final base64String = thumbnail.split(',')[1];
    final decodedBytes = base64Decode(base64String);
    return Image.memory(decodedBytes);
   
  }

  TipsVideoModel copyWith({
    int? position,
    String? title,
    String? link,
    String? source,
    String? date,
    String? thumbnail,
    String? snippet,
    String? length,
    String? image2,
  }) {
    return TipsVideoModel(
      position: position ?? this.position,
      title: title ?? this.title,
      link: link ?? this.link,
      source: source ?? this.source,
      date: date ?? this.date,
      thumbnail: thumbnail ?? this.thumbnail,
      snippet: snippet ?? this.snippet,
      length: length ?? this.length,
      image2: image2 ?? this.image2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'title': title,
      'link': link,
      'source': source,
      'date': date,
      'thumbnail': thumbnail,
      'snippet': snippet,
      'length': length,
      'image2': image2,
    };
  }

  // factory TipsVideoModel.fromMap(Map<String, dynamic> map) {
  //   return TipsVideoModel(
  //     position: map['position'] as int,
  //     title: map['title'] as String,
  //     link: map['link'] as String,
  //     source: map['source'] as String,
  //     date: map['date'] as String,
  //     thumbnail: map['thumbnail'] as String,
  //     snippet: map['snippet'] as String,
  //     length: map['length']  ,
  //   );
  // }

  factory TipsVideoModel.fromMap(Map<String, dynamic> map) {
    return TipsVideoModel(
      position: map['position'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      link: map['link'] as String? ?? '',
      source: map['source'] as String? ?? '',
      date: map['date'] as String? ?? '',
      thumbnail: map['thumbnail'] as String? ?? '',
      snippet: map['snippet'] as String? ?? '',
      length: map['length'] as String? ?? '',
      image2: map['image'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsVideoModel.fromJson(String source) =>
      TipsVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipsModel(position: $position, title: $title, link: $link, source: $source, date: $date, thumbnail: $thumbnail, snippet: $snippet, length: $length, image2: $image2,)';
  }

  @override
  bool operator ==(covariant TipsVideoModel other) {
    if (identical(this, other)) return true;

    return other.position == position &&
        other.title == title &&
        other.link == link &&
        other.source == source &&
        other.date == date &&
        other.thumbnail == thumbnail &&
        other.snippet == snippet &&
        other.length == length;
        
  }

  @override
  int get hashCode {
    return position.hashCode ^
        title.hashCode ^
        link.hashCode ^
        source.hashCode ^
        date.hashCode ^
        thumbnail.hashCode ^
        snippet.hashCode ^
        length.hashCode;
  }
}



class TipsArticleModel {
  
}