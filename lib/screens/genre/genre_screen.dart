import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/artist.dart';
import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';
import '../artist/artist_screen.dart';

const List<Color> mauTheLoai = [
  Colors.indigo,
  Colors.purple,
  Colors.teal,
  Colors.orange,
  Colors.brown,
  Colors.green,
];

Color mauCuaTheLoai(String theLoai) {
  final viTri = DataService.theLoai.indexOf(theLoai);
  if (viTri < 0) return Colors.blueGrey;
  return mauTheLoai[viTri % mauTheLoai.length];
}

class GenreScreen extends StatefulWidget {
  final String theLoai;
  const GenreScreen({super.key, required this.theLoai});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  StreamSubscription? _theoDoiMayPhat;
  String sapXep = 'phobien';

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

  List<Song> get danhSach {
    final ds = duLieu.baiTheoTheLoai(widget.theLoai);
    if (sapXep == 'phobien') {
      ds.sort((a, b) => b.luotNghe.compareTo(a.luotNghe));
    } else if (sapXep == 'moinhat') {
      ds.sort((a, b) => b.ngayDang.compareTo(a.ngayDang));
    } else {
      ds.sort((a, b) => a.title.compareTo(b.title));
    }
    return ds;
  }

  List<Artist> ngheSiTrong(List<Song> ds) {
    final ketQua = <Artist>[];
    for (final bai in ds) {
      if (!ketQua.any((a) => a.id == bai.artist.id)) {
        ketQua.add(bai.artist);
      }
    }
    return ketQua;
  }

  Widget dauTrang(List<Song> ds, Color mau) {
    var tongLuotNghe = 0;
    for (final bai in ds) {
      tongLuotNghe += bai.luotNghe;
    }
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mau, mau.withValues(alpha: 0.6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.album, color: Colors.white, size: 56),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.theLoai,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${ds.length} bài hát • ${soGon(tongLuotNghe)} lượt nghe',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: 48,
            color: Colors.white,
            icon: const Icon(Icons.play_circle_fill),
            onPressed: ds.isEmpty ? null : () => phatBai(ds[0], ds),
          ),
        ],
      ),
    );
  }

  Widget hangNgheSi(List<Artist> dsNgheSi) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        children: [
          for (final ns in dsNgheSi)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: ns),
                ),
              ),
              child: Container(
                width: 80,
                margin: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    AvatarNgheSi(ngheSi: ns, banKinh: 30),
                    const SizedBox(height: 6),
                    Text(
                      ns.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget nutSapXep(String ma, String chu, Color mau) {
    return ChoiceChip(
      label: Text(chu),
      selected: sapXep == ma,
      selectedColor: mau.withValues(alpha: 0.3),
      onSelected: (_) => setState(() => sapXep = ma),
    );
  }

  Widget tieuDe(String chu) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        chu,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mau = mauCuaTheLoai(widget.theLoai);
    final ds = danhSach;
    return Scaffold(
      appBar: AppBar(title: Text(widget.theLoai)),
      body: ListView(
        children: [
          dauTrang(ds, mau),
          if (ds.isNotEmpty) ...[
            tieuDe('Nghệ sĩ'),
            hangNgheSi(ngheSiTrong(ds)),
          ],
          tieuDe('Bài hát'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: [
                nutSapXep('phobien', 'Phổ biến', mau),
                nutSapXep('moinhat', 'Mới nhất', mau),
                nutSapXep('az', 'A - Z', mau),
              ],
            ),
          ),
          if (ds.isEmpty)
            const Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Chưa có bài hát nào',
                textAlign: TextAlign.center,
              ),
            ),
          for (final bai in ds)
            SongTile(
              bai: bai,
              dangChon: baiDangPhat?.id == bai.id,
              onTap: () => phatBai(bai, ds),
              trailing: MenuBaiHat(bai: bai),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
