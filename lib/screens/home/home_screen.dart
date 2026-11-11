import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';
import '../artist/artist_screen.dart';
import '../charts/charts_screen.dart';
import '../library/song_list_screen.dart';
import '../upload/upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget tieuDeMuc(String chu, {VoidCallback? xemTatCa}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              chu,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (xemTatCa != null)
            TextButton(
              onPressed: xemTatCa,
              child: Text(
                tr('Xem tất cả', 'See all'),
                style: const TextStyle(color: mauChinh),
              ),
            ),
        ],
      ),
    );
  }

  Widget theBaiHat(Song bai, List<Song> ds) {
    return GestureDetector(
      onTap: () => phatBai(bai, ds),
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnhBia(
              mau: bai.color,
              anh: bai.artist.anh,
              kichThuoc: 130,
            ),
            const SizedBox(height: 6),
            Text(
              bai.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              bai.artist.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topBai = duLieu.topBai;
    final baiMoi = duLieu.baiMoi;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Music',
          style: TextStyle(
            color: mauChinh,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: tr('Bảng xếp hạng', 'Charts'),
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChartsScreen()),
            ),
          ),
          IconButton(
            tooltip: tr('Tải lên', 'Upload'),
            icon: const Icon(Icons.cloud_upload_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UploadScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              tr(
                'Xin chào, ${duLieu.toi.name} 👋',
                'Hello, ${duLieu.toi.name} 👋',
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          if (dsGanDay.isNotEmpty) ...[
            tieuDeMuc(
              tr('Nghe gần đây', 'Recently played'),
              xemTatCa: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SongListScreen(loai: 'ganday'),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                children: [
                  for (final bai in dsGanDay)
                    theBaiHat(bai, dsGanDay),
                ],
              ),
            ),
          ],

          tieuDeMuc(
            tr('Top bài hát', 'Top tracks'),
            xemTatCa: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChartsScreen()),
            ),
          ),
          for (var i = 0; i < 5 && i < topBai.length; i++)
            SongTile(
              bai: topBai[i],
              hang: i + 1,
              dangChon: baiDangPhat?.id == topBai[i].id,
              onTap: () => phatBai(topBai[i], topBai),
              trailing: MenuBaiHat(bai: topBai[i]),
            ),

          tieuDeMuc(tr('Nghệ sĩ nổi bật', 'Featured artists')),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: [
                for (final ns in duLieu.artists)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArtistScreen(ngheSi: ns),
                      ),
                    ),
                    child: Container(
                      width: 84,
                      margin: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          AvatarNgheSi(ngheSi: ns, banKinh: 34),
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
          ),

          tieuDeMuc(tr('Mới phát hành', 'New releases')),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: [
                for (final bai in baiMoi) theBaiHat(bai, baiMoi),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
