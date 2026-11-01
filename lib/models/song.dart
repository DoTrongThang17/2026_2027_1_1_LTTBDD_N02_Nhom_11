import 'dart:math';

import 'package:flutter/material.dart';

import 'artist.dart';

class Song {
  final String id;
  String title;
  final Artist artist;
  String genre;
  final String audio;
  final Duration duration;
  final Color color;
  final DateTime ngayDang;
  int luotNghe;
  int luotThich;
  bool riengTu;

  final List<double> songAm;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.genre,
    required this.audio,
    required this.duration,
    required this.color,
    required this.ngayDang,
    this.luotNghe = 0,
    this.luotThich = 0,
    this.riengTu = false,
  }) : songAm = taoSongAm(id);

  static List<double> taoSongAm(String id) {
    final ngauNhien = Random(id.hashCode);
    final ketQua = <double>[];
    for (var i = 0; i < 60; i++) {
      ketQua.add(0.2 + ngauNhien.nextDouble() * 0.8);
    }
    return ketQua;
  }

  @override
  String toString() => title;
}
