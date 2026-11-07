import 'package:flutter/material.dart';

import '../../services/data_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';
import '../artist/artist_screen.dart';
import '../playlist/playlist_screen.dart';
import '../upload/upload_screen.dart';
import 'song_list_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Widget dongMenu(
    BuildContext context,
    IconData icon,
    String ten,
    int? soLuong,
    Widget manHinh,
  ) {
    return ListTile(
      leading: Icon(icon, color: mauChinh),
      title: Text(
        ten,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Text(soLuong == null ? '' : '$soLuong'),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => manHinh),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final toi = duLieu.toi;
    return Scaffold(
      appBar: AppBar(title: const Text('Thư viện')),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: AvatarNgheSi(ngheSi: toi, banKinh: 28),
              title: Text(
                toi.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Xem trang cá nhân'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: toi),
                ),
              ),
            ),
          ),
          dongMenu(
            context,
            Icons.favorite,
            'Bài hát đã thích',
            duLieu.baiDaThich.length,
            const SongListScreen(loai: 'thich'),
          ),
          dongMenu(
            context,
            Icons.queue_music,
            'Playlist',
            duLieu.playlists.length,
            const PlaylistScreen(),
          ),
          dongMenu(
            context,
            Icons.people,
            'Đang theo dõi',
            duLieu.ngheSiDangTheoDoi.length,
            const FollowingScreen(),
          ),
          dongMenu(
            context,
            Icons.mic,
            'Bài hát của tôi',
            duLieu.baiCuaToi.length,
            const SongListScreen(loai: 'cuatoi'),
          ),
          dongMenu(
            context,
            Icons.cloud_upload,
            'Tải lên bài hát',
            null,
            const UploadScreen(),
          ),
        ],
      ),
    );
  }
}

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    super.initState();
    duLieu.addListener(_capNhat);
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    duLieu.removeListener(_capNhat);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nghệ sĩ')),
      body: ListView(
        children: [
          for (final ns in duLieu.artists)
            ListTile(
              leading: AvatarNgheSi(ngheSi: ns),
              title: Text(ns.name),
              subtitle: Text(ns.city),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: ns),
                ),
              ),
              trailing: duLieu.dangTheoDoi(ns)
                  ? OutlinedButton(
                      onPressed: () => duLieu.doiTheoDoi(ns),
                      child: const Text('Đang theo dõi'),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mauChinh,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => duLieu.doiTheoDoi(ns),
                      child: const Text('Theo dõi'),
                    ),
            ),
        ],
      ),
    );
  }
}
