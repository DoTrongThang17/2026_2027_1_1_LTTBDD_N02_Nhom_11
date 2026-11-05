import 'package:flutter/material.dart';

import '../../models/playlist.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
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
        title: Text(
          playlist == null
              ? tr('Playlist mới', 'New playlist')
              : tr('Đổi tên', 'Rename'),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: tr('Tên playlist', 'Playlist name'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('Huỷ', 'Cancel')),
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
            child: Text(tr('Lưu', 'Save')),
          ),
        ],
      ),
    );
  }

  void _xoa(Playlist p) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('Xoá playlist', 'Delete playlist')),
        content: Text(tr('Xoá "${p.name}"?', 'Delete "${p.name}"?')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('Huỷ', 'Cancel')),
          ),
          TextButton(
            onPressed: () {
              duLieu.deletePlaylist(p);
              Navigator.pop(context);
            },
            child: Text(tr('Xoá', 'Delete')),
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
          ? Center(
              child: Text(
                tr('Chưa có playlist nào', 'No playlists yet'),
              ),
            )
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
                        tr(
                          '${p.totalSongs} bài hát • '
                              '${p.totalDuration.inMinutes} phút',
                          '${p.totalSongs} songs • '
                              '${p.totalDuration.inMinutes} min',
                        ),
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
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: 'doiten',
                            child: Text(tr('Đổi tên', 'Rename')),
                          ),
                          PopupMenuItem(
                            value: 'xoa',
                            child: Text(tr('Xoá', 'Delete')),
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
