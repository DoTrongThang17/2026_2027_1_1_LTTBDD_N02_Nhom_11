import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/comment.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/am_luong_sheet.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/hen_gio_sheet.dart';
import '../../widgets/song_tile.dart';
import '../../widgets/them_playlist.dart';
import '../../widgets/waveform.dart';
import '../artist/artist_screen.dart';
import 'comment_screen.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  StreamSubscription? _theoDoiTrangThai;
  StreamSubscription? _theoDoiViTri;

  @override
  void initState() {
    super.initState();
    _theoDoiTrangThai = mayPhat.playerStateStream.listen(
      (_) => _capNhat(),
    );
    _theoDoiViTri = mayPhat.positionStream.listen((_) => _capNhat());
    duLieu.addListener(_capNhat);
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _theoDoiTrangThai?.cancel();
    _theoDoiViTri?.cancel();
    duLieu.removeListener(_capNhat);
    super.dispose();
  }

  Comment? binhLuanHienTai(List<Comment> ds) {
    final viTri = mayPhat.position;
    for (final bl in ds) {
      final khoang = viTri - bl.thoiDiem;
      if (khoang >= Duration.zero &&
          khoang < const Duration(seconds: 3)) {
        return bl;
      }
    }
    return null;
  }

  void moHangDoi() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Danh sách phát',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (var i = 0; i < dsPhat.length; i++)
              SongTile(
                bai: dsPhat[i],
                dangChon: i == viTriBai,
                onTap: () {
                  Navigator.pop(ctx);
                  phatBai(dsPhat[i], dsPhat);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bai = baiDangPhat;
    if (bai == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Chưa chọn bài hát nào')),
      );
    }

    final tongThoiGian = mayPhat.duration ?? bai.duration;
    final dsBinhLuan = duLieu.binhLuanCua(bai);
    final blHienTai = binhLuanHienTai(dsBinhLuan);
    final daThich = duLieu.laYeuThich(bai);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đang phát'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 16),
          Center(
            child: AnhBia(
              mau: bai.color,
              anh: bai.artist.anh,
              kichThuoc: 240,
              boGoc: 16,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            bai.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtistScreen(ngheSi: bai.artist),
              ),
            ),
            child: Text(
              bai.artist.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          if (loiPhat != null)
            Text(
              '⚠ Chưa có file nhạc. Hãy chép file vào ${bai.audio}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),

          SizedBox(
            height: 32,
            child: blHienTai == null
                ? null
                : Text(
                    '💬 ${blHienTai.nguoiViet}: ${blHienTai.noiDung}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: mauChinh),
                  ),
          ),

          WaveformBar(
            bai: bai,
            viTri: mayPhat.position,
            tongThoiGian: tongThoiGian,
            binhLuan: dsBinhLuan,
            onTua: (viTri) => tuaDen(viTri),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(doiThoiGian(mayPhat.position)),
              Text(doiThoiGian(tongThoiGian)),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.skip_previous),
                onPressed: () => baiTruoc(),
              ),
              CircleAvatar(
                radius: 34,
                backgroundColor: mauChinh,
                child: dangTai
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        icon: Icon(
                          dangPhat ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: () => tamDungHoacPhat(),
                      ),
              ),
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.skip_next),
                onPressed: () => baiTiepTheo(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                tooltip: 'Thích',
                icon: Icon(
                  daThich ? Icons.favorite : Icons.favorite_border,
                  color: daThich ? mauChinh : null,
                ),
                onPressed: () => duLieu.doiYeuThich(bai),
              ),
              IconButton(
                tooltip: 'Bình luận',
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CommentScreen(bai: bai),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Thêm vào playlist',
                icon: const Icon(Icons.playlist_add),
                onPressed: () => moThemVaoPlaylist(context, bai),
              ),
              IconButton(
                tooltip: 'Danh sách phát',
                icon: const Icon(Icons.queue_music),
                onPressed: moHangDoi,
              ),
              IconButton(
                tooltip: 'Hẹn giờ tắt',
                icon: Icon(
                  gioTat == null
                      ? Icons.bedtime_outlined
                      : Icons.bedtime,
                  color: gioTat == null ? null : mauChinh,
                ),
                onPressed: () => moHenGio(context, _capNhat),
              ),
              IconButton(
                tooltip: 'Âm lượng & tốc độ',
                icon: const Icon(Icons.tune),
                onPressed: () => moAmLuong(context),
              ),
            ],
          ),
          if (gioTat != null)
            Text(
              '⏰ Nhạc sẽ tắt lúc ${gioPhut(gioTat!)}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: mauChinh),
            ),
          if (tocDo != 1)
            Text(
              'Tốc độ: ${tocDo}x',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
