import 'package:flutter/material.dart';

import '../models/song.dart';
import '../services/data_service.dart';
import '../services/setting_service.dart';
import '../theme/app_theme.dart';

void moThemVaoPlaylist(BuildContext context, Song bai) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                tr('Thêm vào playlist', 'Add to playlist'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: mauChinh),
              title: Text(
                tr('Tạo playlist mới', 'Create new playlist'),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _taoPlaylistVaThem(context, bai);
              },
            ),
            for (final p in duLieu.playlists)
              ListTile(
                leading: const Icon(
                  Icons.queue_music,
                  color: mauChinh,
                ),
                title: Text(p.name),
                subtitle: Text(
                  tr(
                    '${p.totalSongs} bài hát',
                    '${p.totalSongs} songs',
                  ),
                ),
                onTap: () {
                  final daThem = duLieu.addSongToPlaylist(p, bai);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        daThem
                            ? tr(
                                'Đã thêm vào "${p.name}"',
                                'Added to "${p.name}"',
                              )
                            : tr(
                                'Bài đã có trong "${p.name}"',
                                'Already in "${p.name}"',
                              ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      );
    },
  );
}

void _taoPlaylistVaThem(BuildContext context, Song bai) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(tr('Playlist mới', 'New playlist')),
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
            if (duLieu.createPlaylist(controller.text)) {
              duLieu.addSongToPlaylist(duLieu.playlists.last, bai);
            }
            Navigator.pop(context);
          },
          child: Text(tr('Tạo', 'Create')),
        ),
      ],
    ),
  );
}
