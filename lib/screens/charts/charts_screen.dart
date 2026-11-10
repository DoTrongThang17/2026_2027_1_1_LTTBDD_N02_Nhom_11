import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/song_tile.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
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

  int giaTri(Song bai, String loai) {
    if (loai == 'nghe') return bai.luotNghe;
    if (loai == 'thich') return bai.luotThich;
    return duLieu.binhLuanCua(bai).length;
  }

  IconData bieuTuong(String loai) {
    if (loai == 'nghe') return Icons.play_arrow;
    if (loai == 'thich') return Icons.favorite;
    return Icons.chat_bubble;
  }

  List<Song> xepHang(String loai) {
    final ds = duLieu.baiCongKhai;
    ds.sort((a, b) => giaTri(b, loai).compareTo(giaTri(a, loai)));
    return ds.take(20).toList();
  }

  Widget theQuanQuan(Song bai, List<Song> ds, String loai) {
    return GestureDetector(
      onTap: () => phatBai(bai, ds),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [mauChinh, Colors.deepOrange],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            AnhBia(
              mau: bai.color,
              anh: bai.artist.anh,
              kichThuoc: 90,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '👑 #1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bai.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bai.artist.name,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      Icon(
                        bieuTuong(loai),
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        soGon(giaTri(bai, loai)),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabXepHang(String loai) {
    final ds = xepHang(loai);
    if (ds.isEmpty) {
      return Center(
        child: Text(tr('Chưa có bài hát nào', 'No tracks yet')),
      );
    }
    return ListView(
      children: [
        theQuanQuan(ds[0], ds, loai),
        for (var i = 1; i < ds.length; i++)
          SongTile(
            bai: ds[i],
            hang: i + 1,
            dangChon: baiDangPhat?.id == ds[i].id,
            onTap: () => phatBai(ds[i], ds),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(bieuTuong(loai), size: 16, color: mauChinh),
                const SizedBox(width: 4),
                Text(soGon(giaTri(ds[i], loai))),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('Bảng xếp hạng', 'Charts')),
          bottom: TabBar(
            labelColor: mauChinh,
            indicatorColor: mauChinh,
            tabs: [
              Tab(text: tr('Nghe nhiều', 'Most played')),
              Tab(text: tr('Yêu thích', 'Most liked')),
              Tab(text: tr('Bình luận', 'Most discussed')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tabXepHang('nghe'),
            tabXepHang('thich'),
            tabXepHang('binhluan'),
          ],
        ),
      ),
    );
  }
}
