import 'package:flutter/material.dart';

import '../models/artist.dart';
<<<<<<< HEAD
import '../models/comment.dart';
=======
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
import '../models/playlist.dart';
import '../models/song.dart';

class DataService extends ChangeNotifier {
  final List<Artist> artists = [];
  final List<Song> songs = [];
  final List<Playlist> playlists = [];
<<<<<<< HEAD
  final Map<String, List<Comment>> _binhLuan = {};
  final Set<String> _daThich = {};
  final Set<String> _dangTheoDoi = {};
=======
  final Set<String> _daThich = {};
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a

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
<<<<<<< HEAD
    final lbb = Artist(
      id: 'lbb',
      name: 'Lê Bảo Bình',
      city: 'TP. HCM',
      color: const Color(0xFF1976D2),
      anh: 'imgs/lebaobinh.jpg',
      followers: 2100000,
    );
=======
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
    final den = Artist(
      id: 'den',
      name: 'Đen Vâu',
      city: 'Quảng Ninh',
      color: const Color(0xFF424242),
      anh: 'imgs/denvau.jpg',
      followers: 4500000,
    );
<<<<<<< HEAD
    final qap = Artist(
      id: 'quanap',
      name: 'Quân A.P',
      city: 'Hà Nội',
      color: const Color(0xFF7B1FA2),
      anh: 'imgs/quanap.jpg',
      followers: 1300000,
    );
    final dg = Artist(
      id: 'datg',
      name: 'Đạt G',
      city: 'TP. HCM',
      color: const Color(0xFF5D4037),
      anh: 'imgs/datg.jpg',
      followers: 2400000,
    );
    final hl = Artist(
      id: 'huongly',
      name: 'Nguyễn Hương Ly',
      city: 'Hà Tĩnh',
      color: const Color(0xFFEC407A),
      anh: 'imgs/nguyenhuongly.jpg',
      followers: 1800000,
    );
    artists.addAll([mtp, hm, lbb, den, qap, dg, hl]);

=======
    artists.addAll([mtp, hm, den]);

    // Khởi tạo danh sách bài hát mẫu đại diện
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
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
<<<<<<< HEAD
      mtp,
      'Hãy Trao Cho Anh',
      'mtp_hay_trao_cho_anh',
      'V-Pop',
      2800000,
      giay: 246,
    );
    themBai(
      mtp,
      'Chúng Ta Của Hiện Tại',
      'mtp_chung_ta_cua_hien_tai',
      'Ballad',
      1900000,
      giay: 302,
    );
    themBai(
      mtp,
      'Em Của Ngày Hôm Qua',
      'mtp_em_cua_ngay_hom_qua',
      'V-Pop',
      1200000,
      giay: 256,
    );

    themBai(
=======
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
      hm,
      'Bắc Bling',
      'hm_bac_bling',
      'V-Pop',
      2600000,
      giay: 259,
    );
    themBai(
<<<<<<< HEAD
      hm,
      'Không Thể Cùng Nhau Suốt Kiếp',
      'hm_khong_the_cung_nhau_suot_kiep',
      'Ballad',
      1350000,
      giay: 300,
    );
    themBai(hm, 'Rời Bỏ', 'hm_roi_bo', 'Ballad', 1100000, giay: 277);
    themBai(hm, 'Thị Mầu', 'hm_thi_mau', 'V-Pop', 1250000, giay: 251);

    themBai(
      lbb,
      'Thích Thì Đến',
      'lbb_thich_thi_den',
      'Ballad',
      1300000,
      giay: 364,
    );
    themBai(
      lbb,
      'Bước Qua Đời Nhau',
      'lbb_buoc_qua_doi_nhau',
      'Ballad',
      1550000,
      giay: 289,
    );
    themBai(
      lbb,
      'Lá Xa Lìa Cành',
      'lbb_la_xa_lia_canh',
      'Ballad',
      1100000,
      giay: 289,
    );
    themBai(
      lbb,
      'Bỏ Lỡ Một Người',
      'lbb_bo_lo_mot_nguoi',
      'Ballad',
      870000,
      giay: 307,
    );

    themBai(
=======
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
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
<<<<<<< HEAD
    themBai(
      den,
      'Trốn Tìm',
      'den_tron_tim',
      'Rap',
      1500000,
      giay: 252,
    );
    themBai(
      den,
      'Đi Về Nhà',
      'den_di_ve_nha',
      'Rap',
      1300000,
      giay: 205,
    );

    themBai(
      qap,
      'Ai Là Người Thương Em',
      'qap_ai_la_nguoi_thuong_em',
      'Ballad',
      1400000,
      giay: 307,
    );
    themBai(
      qap,
      'Còn Gì Đau Hơn Chữ Đã Từng',
      'qap_con_gi_dau_hon_chu_da_tung',
      'Ballad',
      1050000,
      giay: 308,
    );
    themBai(
      qap,
      'Bông Hoa Đẹp Nhất',
      'qap_bong_hoa_dep_nhat',
      'Ballad',
      1200000,
      giay: 357,
    );

    themBai(
      dg,
      'Buồn Của Anh',
      'dg_buon_cua_anh',
      'Ballad',
      1300000,
      giay: 279,
    );
    themBai(dg, 'Về', 'dg_ve', 'Ballad', 820000, giay: 325);
    themBai(
      dg,
      'Thêm Bao Nhiêu Lâu',
      'dg_them_bao_nhieu_lau',
      'Ballad',
      950000,
      giay: 302,
    );
    themBai(
      dg,
      'Bánh Mì Không',
      'dg_banh_mi_khong',
      'V-Pop',
      1080000,
      giay: 244,
    );

    themBai(
      hl,
      'Độ Ta Không Độ Nàng',
      'hl_do_ta_khong_do_nang',
      'Ballad',
      1150000,
      giay: 200,
    );
    themBai(
      hl,
      'Đừng Yêu Nữa, Em Mệt Rồi',
      'hl_dung_yeu_nua_em_met_roi',
      'Ballad',
      990000,
      giay: 295,
    );
    themBai(
      hl,
      'Một Bước Yêu Vạn Dặm Đau',
      'hl_mot_buoc_yeu_van_dam_dau',
      'Ballad',
      870000,
      giay: 266,
    );

    _binhLuan['mtp_lac_troi'] = [
      Comment(
        nguoiViet: 'Minh Anh',
        mau: Colors.teal,
        noiDung: 'Nghe bao nhiêu lần vẫn nổi da gà',
        thoiDiem: const Duration(seconds: 15),
      ),
      Comment(
        nguoiViet: 'Quốc Bảo',
        mau: Colors.deepPurple,
        noiDung: 'Đoạn này đỉnh quá',
        thoiDiem: const Duration(seconds: 62),
      ),
    ];
    _binhLuan['hm_bac_bling'] = [
      Comment(
        nguoiViet: 'Linh',
        mau: Colors.purple,
        noiDung: 'Tự hào Bắc Ninh 🔥',
        thoiDiem: const Duration(seconds: 10),
      ),
      Comment(
        nguoiViet: 'Khang',
        mau: Colors.green,
        noiDung: 'Giai điệu dân ca phối mới quá hay',
        thoiDiem: const Duration(seconds: 48),
      ),
    ];
    _binhLuan['den_mang_tien_ve_cho_me'] = [
      Comment(
        nguoiViet: 'Hà Vy',
        mau: Colors.red,
        noiDung: 'Nghe xong muốn về nhà ngay',
        thoiDiem: const Duration(seconds: 30),
      ),
    ];

    _daThich.addAll(['mtp_lac_troi', 'den_bai_nay_chill_phet']);
    _dangTheoDoi.addAll(['mtp', 'den', 'hoaminzy']);
=======

    // Khởi tạo dữ liệu yêu thích và playlist ban đầu
    _daThich.addAll(['mtp_lac_troi', 'den_bai_nay_chill_phet']);
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
    playlists.add(
      Playlist(
        id: 'p1',
        name: 'Nghe cuối tuần',
<<<<<<< HEAD
        songs: [songs[0], songs[5], songs[13]],
=======
        songs: [songs[0], songs[2], songs[4]],
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
      ),
    );
  }

<<<<<<< HEAD
=======
  // --- QUẢN LÝ DANH SÁCH BÀI HÁT & NGHỆ SĨ ---
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
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

<<<<<<< HEAD
  List<Song> get baiCuaToi => baiCuaNgheSi(toi);

  List<Song> timKiem(String tuKhoa) {
    final key = tuKhoa.toLowerCase().trim();
    if (key.isEmpty) return [];
    return baiCongKhai.where((s) {
      return s.title.toLowerCase().contains(key) ||
          s.artist.name.toLowerCase().contains(key) ||
          s.genre.toLowerCase().contains(key);
    }).toList();
  }

  List<Artist> timNgheSi(String tuKhoa) {
    final key = tuKhoa.toLowerCase().trim();
    if (key.isEmpty) return [];
    return artists
        .where((a) => a.name.toLowerCase().contains(key))
        .toList();
  }

=======
  // --- QUẢN LÝ YÊU THÍCH ---
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
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

<<<<<<< HEAD
  bool dangTheoDoi(Artist a) => _dangTheoDoi.contains(a.id);

  void doiTheoDoi(Artist a) {
    if (_dangTheoDoi.contains(a.id)) {
      _dangTheoDoi.remove(a.id);
      a.followers--;
    } else {
      _dangTheoDoi.add(a.id);
      a.followers++;
    }
    notifyListeners();
  }

  List<Artist> get ngheSiDangTheoDoi =>
      artists.where((a) => _dangTheoDoi.contains(a.id)).toList();

  List<Song> get feed => baiMoi
      .where(
        (s) =>
            _dangTheoDoi.contains(s.artist.id) ||
            s.artist.id == toi.id,
      )
      .toList();

  List<Comment> binhLuanCua(Song bai) {
    final ds = List<Comment>.from(_binhLuan[bai.id] ?? []);
    ds.sort((a, b) => a.thoiDiem.compareTo(b.thoiDiem));
    return ds;
  }

  void themBinhLuan(Song bai, String noiDung, Duration thoiDiem) {
    _binhLuan.putIfAbsent(bai.id, () => []);
    _binhLuan[bai.id]!.add(
      Comment(
        nguoiViet: toi.name,
        mau: toi.color,
        noiDung: noiDung,
        thoiDiem: thoiDiem,
      ),
    );
    notifyListeners();
  }

  void taiLenBai({
    required String tenBai,
    required String theLoai,
    required String audio,
    required Duration thoiLuong,
    required Color mau,
    required bool riengTu,
  }) {
    songs.add(
      Song(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: tenBai,
        artist: toi,
        genre: theLoai,
        audio: audio,
        duration: thoiLuong,
        color: mau,
        ngayDang: DateTime.now(),
        riengTu: riengTu,
      ),
    );
    notifyListeners();
  }

  void xoaBai(Song bai) {
    songs.removeWhere((s) => s.id == bai.id);
    _daThich.remove(bai.id);
    for (final p in playlists) {
      p.songs.removeWhere((s) => s.id == bai.id);
    }
    notifyListeners();
  }

=======
  // --- QUẢN LÝ PLAYLIST ---
>>>>>>> 8e60ab81df23e1a72d0000b665f64f89d826956a
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
