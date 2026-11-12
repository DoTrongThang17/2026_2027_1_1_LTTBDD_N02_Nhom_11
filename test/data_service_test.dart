import 'package:flutter_test/flutter_test.dart';
import 'package:bai_tap_cuoi_ki/services/data_service.dart';
import 'package:bai_tap_cuoi_ki/widgets/dinh_dang.dart';

void main() {
  test('Định dạng thời gian và số', () {
    expect(doiThoiGian(const Duration(seconds: 76)), '1:16');
    expect(soGon(1500), '1.5K');
  });

  test('Thích và bỏ thích bài hát', () {
    final ds = DataService();
    final bai = ds.songs[0];
    final luotThichBanDau = bai.luotThich;
    ds.doiYeuThich(bai);
    expect(ds.laYeuThich(bai), true);
    expect(bai.luotThich, luotThichBanDau + 1);
    ds.doiYeuThich(bai);
    expect(ds.laYeuThich(bai), false);
  });

  test('Tìm kiếm bài hát', () {
    final ds = DataService();
    expect(ds.timKiem('lạc trôi').length, 1);
    expect(ds.timKiem('').length, 0);
  });

  test('Tạo playlist và thêm bài', () {
    final ds = DataService();
    expect(ds.createPlaylist('Test'), true);
    final p = ds.playlists.last;
    expect(ds.addSongToPlaylist(p, ds.songs[0]), true);
    expect(ds.addSongToPlaylist(p, ds.songs[0]), false);
  });
}
