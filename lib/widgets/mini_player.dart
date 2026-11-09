import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/player/player_screen.dart';
import '../services/audio_service.dart';
import '../services/data_service.dart';
import '../services/setting_service.dart';
import '../theme/app_theme.dart';
import 'anh_bia.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
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
    caiDat.addListener(_capNhat);
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _theoDoiTrangThai?.cancel();
    _theoDoiViTri?.cancel();
    duLieu.removeListener(_capNhat);
    caiDat.removeListener(_capNhat);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bai = baiDangPhat;
    if (bai == null) return const SizedBox();

    final tong = (mayPhat.duration ?? bai.duration).inMilliseconds;
    double tienDo = tong > 0
        ? mayPhat.position.inMilliseconds / tong
        : 0;
    if (tienDo > 1) tienDo = 1;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PlayerScreen()),
        );
      },
      child: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: tienDo,
              minHeight: 2,
              color: mauChinh,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: Row(
                children: [
                  AnhBia(
                    mau: bai.color,
                    anh: bai.artist.anh,
                    kichThuoc: 42,
                    boGoc: 4,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bai.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          loiPhat == null
                              ? bai.artist.name
                              : tr(
                                  'Chưa có file nhạc cho bài này',
                                  'Audio file missing',
                                ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: loiPhat == null
                                ? Colors.grey
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: tr('Thích', 'Like'),
                    icon: Icon(
                      duLieu.laYeuThich(bai)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: duLieu.laYeuThich(bai) ? mauChinh : null,
                    ),
                    onPressed: () => duLieu.doiYeuThich(bai),
                  ),
                  IconButton(
                    icon: Icon(
                      dangPhat ? Icons.pause : Icons.play_arrow,
                      size: 30,
                    ),
                    onPressed: () => tamDungHoacPhat(),
                  ),
                  IconButton(
                    tooltip: tr('Bài tiếp theo', 'Next'),
                    icon: const Icon(Icons.skip_next, size: 30),
                    onPressed: () => baiTiepTheo(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
