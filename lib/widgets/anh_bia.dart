import 'package:flutter/material.dart';

import '../models/artist.dart';

class AnhBia extends StatelessWidget {
  final Color mau;
  final double kichThuoc;
  final double boGoc;
  final String? anh;

  const AnhBia({
    super.key,
    required this.mau,
    this.kichThuoc = 50,
    this.boGoc = 8,
    this.anh,
  });

  @override
  Widget build(BuildContext context) {
    if (anh != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(boGoc),
        child: Image.asset(
          anh!,
          width: kichThuoc,
          height: kichThuoc,
          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) => _khungMau(),
        ),
      );
    }
    return _khungMau();
  }

  Widget _khungMau() {
    return Container(
      width: kichThuoc,
      height: kichThuoc,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(boGoc),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [mau, Colors.black87],
        ),
      ),
      child: Icon(
        Icons.music_note,
        color: Colors.white,
        size: kichThuoc * 0.4,
      ),
    );
  }
}

class AvatarNgheSi extends StatelessWidget {
  final Artist ngheSi;
  final double banKinh;

  const AvatarNgheSi({
    super.key,
    required this.ngheSi,
    this.banKinh = 24,
  });

  @override
  Widget build(BuildContext context) {
    final chuCai = CircleAvatar(
      radius: banKinh,
      backgroundColor: ngheSi.color,
      child: Text(
        ngheSi.chuCaiDau,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: banKinh * 0.8,
        ),
      ),
    );
    if (ngheSi.anh == null) return chuCai;

    return ClipOval(
      child: Image.asset(
        ngheSi.anh!,
        width: banKinh * 2,
        height: banKinh * 2,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => chuCai,
      ),
    );
  }
}
