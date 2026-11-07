import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';

class SongListScreen extends StatefulWidget {
  final String loai;
  final String? theLoai;

  const SongListScreen({super.key, required this.loai, this.theLoai});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
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

  String get _tieuDe {
    switch (widget.loai) {
      case 'top':
        return tr('Top bài hát', 'Top tracks');
      case 'thich':
        return tr('Bài hát đã thích', 'Liked tracks');
      case 'cuatoi':
        return tr('Bài hát của tôi', 'My tracks');
      case 'ganday':
        return tr('Nghe gần đây', 'Recently played');
      default:
        return widget.theLoai ?? '';
    }
  }

  List<Song> get _danhSach {
    switch (widget.loai) {
      case 'top':
        return duLieu.topBai;
      case 'thich':
        return duLieu.baiDaThich;
      case 'cuatoi':
        return duLieu.baiCuaToi;
      case 'ganday':
        return dsGanDay;
      default:
        return duLieu.baiTheoTheLoai(widget.theLoai ?? '');
    }
  }

  void _xoaBai(Song bai) async {
    final dongY = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('Xoá bài hát', 'Delete track')),
        content: Text(
          tr('Xoá "${bai.title}"?', 'Delete "${bai.title}"?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(tr('Huỷ', 'Cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(tr('Xoá', 'Delete')),
          ),
        ],
      ),
    );
    if (dongY == true) duLieu.xoaBai(bai);
  }

  @override
  Widget build(BuildContext context) {
    final ds = _danhSach;
    return Scaffold(
      appBar: AppBar(title: Text(_tieuDe)),
      body: ds.isEmpty
          ? Center(
              child: Text(tr('Chưa có bài hát nào', 'No tracks yet')),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        tr(
                          '${ds.length} bài hát',
                          '${ds.length} tracks',
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mauChinh,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => phatBai(ds[0], ds),
                        icon: const Icon(Icons.play_arrow),
                        label: Text(tr('Phát tất cả', 'Play all')),
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < ds.length; i++)
                  SongTile(
                    bai: ds[i],
                    hang: widget.loai == 'top' ? i + 1 : null,
                    dangChon: baiDangPhat?.id == ds[i].id,
                    onTap: () => phatBai(ds[i], ds),
                    trailing: widget.loai == 'cuatoi'
                        ? IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _xoaBai(ds[i]),
                          )
                        : MenuBaiHat(bai: ds[i]),
                  ),
              ],
            ),
    );
  }
}
