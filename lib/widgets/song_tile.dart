import 'package:flutter/material.dart';

import '../models/song.dart';
import '../theme/app_theme.dart';
import 'anh_bia.dart';
import 'dinh_dang.dart';

class SongTile extends StatelessWidget {
  final Song bai;
  final VoidCallback onTap;
  final bool dangChon;
  final int? hang;
  final Widget? trailing;

  const SongTile({
    super.key,
    required this.bai,
    required this.onTap,
    this.dangChon = false,
    this.hang,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final mauPhu = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.6);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hang != null)
            SizedBox(
              width: 28,
              child: Text(
                '$hang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: hang! <= 3 ? mauChinh : mauPhu,
                ),
              ),
            ),
          AnhBia(mau: bai.color, anh: bai.artist.anh),
        ],
      ),
      title: Text(
        bai.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: dangChon ? mauChinh : null,
        ),
      ),
      subtitle: Text(
        '${bai.artist.name}  •  ▶ ${soGon(bai.luotNghe)}  •  '
        '${doiThoiGian(bai.duration)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: mauPhu),
      ),
      trailing:
          trailing ??
          Icon(
            dangChon ? Icons.graphic_eq : Icons.play_arrow,
            color: mauChinh,
          ),
    );
  }
}
