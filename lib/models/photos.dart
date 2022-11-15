
import 'package:flutter/widgets.dart';

class Photo {
  final String id;
  final String url;
  final String createdAt;

  Photo({
    required this.id,
    required this.url,
    required this.createdAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      url: json['url'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'createdAt': createdAt,
  };
}