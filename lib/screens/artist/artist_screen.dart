import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/artist.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';

class ArtistScreen extends StatefulWidget {
  final Artist ngheSi;
  const ArtistScreen({super.key, required this.ngheSi});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  StreamSubscription? _theoDoiMayPhat;

  @override
  void initState() {
    super.initState();
    duLieu.addListener(_capNhat);
    _theoDoiMayPhat = mayPhat.playerStateStream.listen(
      (_) => _capNhat(),
    );
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    duLieu.removeListener(_capNhat);
    _theoDoiMayPhat?.cancel();
    super.dispose();
  }

  Widget soLieu(String so, String chu) {
    return Column(
      children: [
        Text(
          so,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          chu,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ns = widget.ngheSi;
    final dsBai = duLieu.baiCuaNgheSi(ns);
    final laToi = ns.id == duLieu.toi.id;
    final dangTheoDoi = duLieu.dangTheoDoi(ns);

    return Scaffold(
      appBar: AppBar(title: Text(ns.name)),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ns.color, Colors.black87],
              ),
            ),
            child: Column(
              children: [
                AvatarNgheSi(ngheSi: ns, banKinh: 48),
                const SizedBox(height: 12),
                Text(
                  ns.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ns.city,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    soLieu(
                      soGon(ns.followers),
                      tr('Người theo dõi', 'Followers'),
                    ),
                    soLieu(
                      '${dsBai.length}',
                      tr('Bài hát', 'Tracks'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!laToi)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dangTheoDoi
                          ? Colors.white
                          : mauChinh,
                      foregroundColor: dangTheoDoi
                          ? Colors.black
                          : Colors.white,
                    ),
                    onPressed: () => duLieu.doiTheoDoi(ns),
                    icon: Icon(
                      dangTheoDoi ? Icons.check : Icons.person_add,
                    ),
                    label: Text(
                      dangTheoDoi
                          ? tr('Đang theo dõi', 'Following')
                          : tr('Theo dõi', 'Follow'),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              tr('Bài hát', 'Tracks'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (dsBai.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                tr('Chưa có bài hát nào', 'No tracks yet'),
                textAlign: TextAlign.center,
              ),
            ),
          for (final bai in dsBai)
            SongTile(
              bai: bai,
              dangChon: baiDangPhat?.id == bai.id,
              onTap: () => phatBai(bai, dsBai),
              trailing: MenuBaiHat(bai: bai),
            ),
        ],
      ),
    );
  }
}
