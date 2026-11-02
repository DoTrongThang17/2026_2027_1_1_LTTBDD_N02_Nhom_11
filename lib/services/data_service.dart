import 'package:flutter/material.dart';

import '../models/artist.dart';
import '../models/playlist.dart';
import '../models/song.dart';

class DataService extends ChangeNotifier {
  final List<Artist> artists = [];
  final List<Song> songs = [];
  final List<Playlist> playlists = [];
  final Set<String> _daThich = {};

  final Artist toi = Artist(
    id: 'me',
    name: 'Bạn',
    city: 'Hà Nội',
    color: const Color(0xFFFF5500),
  );

  static const List<String> theLoai = ['V-Pop', 'Ballad', 'Rap'];

  DataService() {
    _taoDuLieuMau();
  }

  void _taoDuLieuMau() {
    final now = DateTime.now();
    int dem = 0;

    void themBai(
      Artist ns,
      String ten,
      String file,
      String theLoai,
      int luotNghe, {
      int giay = 240,
    }) {
      dem++;
      songs.add(
        Song(
          id: file,
          title: ten,
          artist: ns,
          genre: theLoai,
          audio: 'audio/$file.mp3',
          duration: Duration(seconds: giay),
          color: ns.color,
          ngayDang: now.subtract(Duration(days: dem * 2)),
          luotNghe: luotNghe,
          luotThich: luotNghe ~/ 20,
        ),
      );
    }

    final mtp = Artist(
      id: 'mtp',
      name: 'Sơn Tùng M-TP',
      city: 'Thái Bình',
      color: const Color(0xFFD32F2F),
      anh: 'imgs/sontungmtp.jpg',
      followers: 8200000,
    );
    final hm = Artist(
      id: 'hoaminzy',
      name: 'Hòa Minzy',
      city: 'Bắc Ninh',
      color: const Color(0xFFF57C00),
      anh: 'imgs/hoaminzy.jpg',
      followers: 5100000,
    );
    final den = Artist(
      id: 'den',
      name: 'Đen Vâu',
      city: 'Quảng Ninh',
      color: const Color(0xFF424242),
      anh: 'imgs/denvau.jpg',
      followers: 4500000,
    );
    artists.addAll([mtp, hm, den]);

    // Khởi tạo danh sách bài hát mẫu đại diện
    themBai(
      mtp,
      'Lạc Trôi',
      'mtp_lac_troi',
      'V-Pop',
      2450000,
      giay: 233,
    );
    themBai(
      mtp,
      'Nơi Này Có Anh',
      'mtp_noi_nay_co_anh',
      'V-Pop',
      2100000,
      giay: 278,
    );
    themBai(
      hm,
      'Bắc Bling',
      'hm_bac_bling',
      'V-Pop',
      2600000,
      giay: 259,
    );
    themBai(
      den,
      'Mang Tiền Về Cho Mẹ',
      'den_mang_tien_ve_cho_me',
      'Rap',
      1950000,
      giay: 405,
    );
    themBai(
      den,
      'Bài Này Chill Phết',
      'den_bai_nay_chill_phet',
      'Rap',
      1700000,
      giay: 273,
    );

    // Khởi tạo dữ liệu yêu thích và playlist ban đầu
    _daThich.addAll(['mtp_lac_troi', 'den_bai_nay_chill_phet']);
    playlists.add(
      Playlist(
        id: 'p1',
        name: 'Nghe cuối tuần',
        songs: [songs[0], songs[2], songs[4]],
      ),
    );
  }

  // --- QUẢN LÝ DANH SÁCH BÀI HÁT & NGHỆ SĨ ---
  List<Song> get baiCongKhai => songs
      .where((s) => !s.riengTu || s.artist.id == toi.id)
      .toList();

  List<Song> get topBai {
    final ds = baiCongKhai;
    ds.sort((a, b) => b.luotNghe.compareTo(a.luotNghe));
    return ds;
  }

  List<Song> get baiMoi {
    final ds = baiCongKhai;
    ds.sort((a, b) => b.ngayDang.compareTo(a.ngayDang));
    return ds;
  }

  List<Song> baiTheoTheLoai(String tl) =>
      baiCongKhai.where((s) => s.genre == tl).toList();

  List<Song> baiCuaNgheSi(Artist a) =>
      baiMoi.where((s) => s.artist.id == a.id).toList();

  // --- QUẢN LÝ YÊU THÍCH ---
  bool laYeuThich(Song bai) => _daThich.contains(bai.id);

  void doiYeuThich(Song bai) {
    if (_daThich.contains(bai.id)) {
      _daThich.remove(bai.id);
      bai.luotThich--;
    } else {
      _daThich.add(bai.id);
      bai.luotThich++;
    }
    notifyListeners();
  }

  List<Song> get baiDaThich =>
      songs.where((s) => _daThich.contains(s.id)).toList();

  // --- QUẢN LÝ PLAYLIST ---
  bool createPlaylist(String name) {
    if (name.trim().isEmpty) return false;
    playlists.add(
      Playlist(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        songs: [],
      ),
    );
    notifyListeners();
    return true;
  }

  bool renamePlaylist(Playlist p, String name) {
    if (name.trim().isEmpty) return false;
    p.name = name.trim();
    notifyListeners();
    return true;
  }

  void deletePlaylist(Playlist p) {
    playlists.remove(p);
    notifyListeners();
  }

  bool addSongToPlaylist(Playlist p, Song bai) {
    if (p.songs.any((s) => s.id == bai.id)) return false;
    p.songs.add(bai);
    notifyListeners();
    return true;
  }

  void removeSongFromPlaylist(Playlist p, Song bai) {
    p.songs.removeWhere((s) => s.id == bai.id);
    notifyListeners();
  }
}

final DataService duLieu = DataService();
