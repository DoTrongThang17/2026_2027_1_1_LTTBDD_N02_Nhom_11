import 'package:flutter/material.dart';

class Artist {
  final String id;
  String name;
  String city;
  final Color color;
  final String? anh;
  int followers;

  Artist({
    required this.id,
    required this.name,
    required this.city,
    required this.color,
    this.anh,
    this.followers = 0,
  });

  String get chuCaiDau => name.isEmpty ? '?' : name[0].toUpperCase();

  @override
  String toString() => name;
}
