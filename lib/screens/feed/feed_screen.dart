import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/dinh_dang.dart';
import '../../widgets/them_playlist.dart';
import '../artist/artist_screen.dart';
import '../player/comment_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  String thoiGianTruoc(DateTime t) {
    final khoang = DateTime.now().difference(t);
    if (khoang.inHours < 1) {
      return tr(
        '${khoang.inMinutes} phút trước',
        '${khoang.inMinutes}m ago',
      );
    }
    if (khoang.inDays < 1) {
      return tr(
        '${khoang.inHours} giờ trước',
        '${khoang.inHours}h ago',
      );
    }
    return tr('${khoang.inDays} ngày trước', '${khoang.inDays}d ago');
  }

  Widget theBaiDang(BuildContext context, Song bai, List<Song> ds) {
    final daThich = duLieu.laYeuThich(bai);
    final dangPhatBaiNay = baiDangPhat?.id == bai.id;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: bai.artist),
                ),
              ),
              child: Row(
                children: [
                  AvatarNgheSi(ngheSi: bai.artist, banKinh: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${bai.artist.name} '
                      '${tr('đã đăng một bài', 'posted a track')}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    thoiGianTruoc(bai.ngayDang),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            InkWell(
              onTap: () => phatBai(bai, ds),
              child: Row(
                children: [
                  AnhBia(
                    mau: bai.color,
                    anh: bai.artist.anh,
                    kichThuoc: 80,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bai.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangPhatBaiNay ? mauChinh : null,
                          ),
                        ),
                        Text(
                          '#${bai.genre}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        if (bai.riengTu)
                          Text(
                            tr('🔒 Riêng tư', '🔒 Private'),
                            style: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    dangPhatBaiNay && dangPhat
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: mauChinh,
                    size: 44,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                TextButton.icon(
                  onPressed: () => duLieu.doiYeuThich(bai),
                  icon: Icon(
                    daThich ? Icons.favorite : Icons.favorite_border,
                    color: mauChinh,
                  ),
                  label: Text(soGon(bai.luotThich)),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CommentScreen(bai: bai),
                    ),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: Text('${duLieu.binhLuanCua(bai).length}'),
                ),
                IconButton(
                  onPressed: () => moThemVaoPlaylist(context, bai),
                  icon: const Icon(Icons.playlist_add),
                ),
                const Spacer(),
                Text(
                  '▶ ${soGon(bai.luotNghe)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = duLieu.feed;
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: ds.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  tr(
                    'Hãy theo dõi nghệ sĩ để xem '
                        'bài mới của họ ở đây',
                    'Follow artists to see their new tracks here',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              children: [
                for (final bai in ds) theBaiDang(context, bai, ds),
              ],
            ),
    );
  }
}
