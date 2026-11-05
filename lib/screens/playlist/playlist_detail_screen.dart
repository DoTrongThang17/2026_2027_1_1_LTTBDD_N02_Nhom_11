import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/playlist.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/song_tile.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final Playlist playlist;
  const PlaylistDetailScreen({super.key, required this.playlist});

  @override
  State<PlaylistDetailScreen> createState() =>
      _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  StreamSubscription? _theoDoiMayPhat;

  @override
  void initState() {
    super.initState();
    duLieu.addListener(_capNhat);
    _theoDoiMayPhat = mayPhat.playerStateStream.listen(
      (_) => _capNhat(),
    );
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    duLieu.removeListener(_capNhat);
    _theoDoiMayPhat?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.playlist;
    final ds = p.songs;
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [mauChinh, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.queue_music,
                  color: Colors.white,
                  size: 56,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tr(
                          '${p.totalSongs} bài hát',
                          '${p.totalSongs} songs',
                        ),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 48,
                  color: Colors.white,
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: ds.isEmpty
                      ? null
                      : () => phatBai(ds[0], ds),
                ),
              ],
            ),
          ),
          if (ds.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                tr(
                  'Playlist trống. Bấm ⋮ ở một bài hát để thêm vào.',
                  'Empty playlist. Tap ⋮ on a track to add it.',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          for (final bai in List.of(ds))
            SongTile(
              bai: bai,
              dangChon: baiDangPhat?.id == bai.id,
              onTap: () => phatBai(bai, ds),
              trailing: IconButton(
                tooltip: tr(
                  'Gỡ khỏi playlist',
                  'Remove from playlist',
                ),
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () =>
                    duLieu.removeSongFromPlaylist(p, bai),
              ),
            ),
        ],
      ),
    );
  }
}
