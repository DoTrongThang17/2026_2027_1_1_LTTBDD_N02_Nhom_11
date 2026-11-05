import 'package:flutter/material.dart';

import '../../models/playlist.dart';
import '../../services/data_service.dart';
import '../../theme/app_theme.dart';
import 'playlist_detail_screen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
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

  void _hopThoaiTen({Playlist? playlist}) {
    final controller = TextEditingController(
      text: playlist?.name ?? '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(playlist == null ? 'Playlist mới' : 'Đổi tên'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Tên playlist'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () {
              if (playlist == null) {
                duLieu.createPlaylist(controller.text);
              } else {
                duLieu.renamePlaylist(playlist, controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _xoa(Playlist p) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xoá playlist'),
        content: Text('Xoá "${p.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () {
              duLieu.deletePlaylist(p);
              Navigator.pop(context);
            },
            child: const Text('Xoá'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = duLieu.playlists;
    return Scaffold(
      appBar: AppBar(title: const Text('Playlist')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mauChinh,
        foregroundColor: Colors.white,
        onPressed: () => _hopThoaiTen(),
        child: const Icon(Icons.add),
      ),
      body: ds.isEmpty
          ? const Center(child: Text('Chưa có playlist nào'))
          : ListView(
              children: [
                for (final p in ds)
                  Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: mauChinh,
                        foregroundColor: Colors.white,
                        child: Text('${p.totalSongs}'),
                      ),
                      title: Text(
                        p.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${p.totalSongs} bài hát • ${p.totalDuration.inMinutes} phút',
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PlaylistDetailScreen(playlist: p),
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (chon) => chon == 'doiten'
                            ? _hopThoaiTen(playlist: p)
                            : _xoa(p),
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'doiten',
                            child: Text('Đổi tên'),
                          ),
                          PopupMenuItem(
                            value: 'xoa',
                            child: Text('Xoá'),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
