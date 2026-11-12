import 'package:flutter/material.dart';

import '../models/song.dart';
import '../screens/artist/artist_screen.dart';
import '../screens/player/comment_screen.dart';
import '../services/data_service.dart';
import '../services/setting_service.dart';
import 'them_playlist.dart';

class MenuBaiHat extends StatelessWidget {
  final Song bai;
  const MenuBaiHat({super.key, required this.bai});

  @override
  Widget build(BuildContext context) {
    final daThich = duLieu.laYeuThich(bai);
    return PopupMenuButton<String>(
      onSelected: (chon) {
        if (chon == 'thich') {
          duLieu.doiYeuThich(bai);
        } else if (chon == 'playlist') {
          moThemVaoPlaylist(context, bai);
        } else if (chon == 'binhluan') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CommentScreen(bai: bai),
            ),
          );
        } else if (chon == 'nghesi') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArtistScreen(ngheSi: bai.artist),
            ),
          );
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'thich',
          child: Text(
            daThich ? tr('Bỏ thích', 'Unlike') : tr('Thích', 'Like'),
          ),
        ),
        PopupMenuItem(
          value: 'playlist',
          child: Text(tr('Thêm vào playlist', 'Add to playlist')),
        ),
        PopupMenuItem(
          value: 'binhluan',
          child: Text(tr('Bình luận', 'Comments')),
        ),
        PopupMenuItem(
          value: 'nghesi',
          child: Text(tr('Trang nghệ sĩ', 'Go to artist')),
        ),
      ],
    );
  }
}
