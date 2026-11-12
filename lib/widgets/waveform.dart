import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../models/song.dart';
import '../theme/app_theme.dart';

class WaveformBar extends StatelessWidget {
  final Song bai;
  final Duration viTri;
  final Duration tongThoiGian;
  final ValueChanged<Duration> onTua;
  final List<Comment> binhLuan;

  const WaveformBar({
    super.key,
    required this.bai,
    required this.viTri,
    required this.tongThoiGian,
    required this.onTua,
    this.binhLuan = const [],
  });

  @override
  Widget build(BuildContext context) {
    final tong = tongThoiGian.inMilliseconds;

    double tiLe = tong > 0 ? viTri.inMilliseconds / tong : 0;
    if (tiLe > 1) tiLe = 1;
    final soCot = bai.songAm.length;
    final mauChuaNghe = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.25);

    return LayoutBuilder(
      builder: (context, constraints) {
        final rong = constraints.maxWidth;
        return Column(
          children: [
            GestureDetector(
              onTapDown: (chiTiet) {
                final phanTram = chiTiet.localPosition.dx / rong;
                onTua(
                  Duration(milliseconds: (tong * phanTram).round()),
                );
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < soCot; i++)
                      Expanded(
                        child: Container(
                          height: 60 * bai.songAm[i],
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                          ),
                          color: i / soCot < tiLe
                              ? mauChinh
                              : mauChuaNghe,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            if (binhLuan.isNotEmpty && tong > 0)
              SizedBox(
                height: 24,
                child: Stack(
                  children: [
                    for (final bl in binhLuan)
                      Positioned(
                        left:
                            (bl.thoiDiem.inMilliseconds / tong) *
                            (rong - 20),
                        top: 4,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: bl.mau,
                          child: Text(
                            bl.nguoiViet[0],
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
