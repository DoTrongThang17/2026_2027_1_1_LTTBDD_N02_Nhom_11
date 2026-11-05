import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/waveform.dart';
import '../artist/artist_screen.dart';

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
          const SizedBox(height: 32),
          WaveformBar(
            bai: bai,
            viTri: mayPhat.position,
            tongThoiGian: tongThoiGian,
            onTua: (viTri) => tuaDen(viTri),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(doiThoiGian(mayPhat.position)),
              Text(doiThoiGian(tongThoiGian)),
            ],
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
