import 'package:flutter/material.dart';

import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';
import '../artist/artist_screen.dart';
import '../genre/genre_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String tuKhoa = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void timLai(String tu) {
    _controller.text = tu;
    setState(() => tuKhoa = tu);
    caiDat.themLichSuTim(tu);
  }

  Widget tieuDe(String chu, {List<Widget> nut = const []}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              chu,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...nut,
        ],
      ),
    );
  }

  Widget manHinhDau() {
    final lichSu = caiDat.lichSuTim;
    return ListView(
      children: [
        if (lichSu.isNotEmpty) ...[
          tieuDe(
            tr('Tìm kiếm gần đây', 'Recent searches'),
            nut: [
              TextButton(
                onPressed: () => caiDat.xoaHetLichSuTim(),
                child: Text(tr('Xoá tất cả', 'Clear all')),
              ),
            ],
          ),
          for (final tu in lichSu)
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(tu),
              onTap: () => timLai(tu),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => caiDat.xoaLichSuTim(tu),
              ),
            ),
        ],
        tieuDe(tr('Thể loại', 'Genres')),
        oTheLoai(),
      ],
    );
  }

  Widget oTheLoai() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        for (var i = 0; i < DataService.theLoai.length; i++)
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    GenreScreen(theLoai: DataService.theLoai[i]),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: mauCuaTheLoai(DataService.theLoai[i]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                DataService.theLoai[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget ketQua() {
    final dsBai = duLieu.timKiem(tuKhoa);
    final dsNgheSi = duLieu.timNgheSi(tuKhoa);

    if (dsBai.isEmpty && dsNgheSi.isEmpty) {
      return Center(
        child: Text(tr('Không tìm thấy kết quả', 'No results found')),
      );
    }

    return ListView(
      children: [
        if (dsNgheSi.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              tr('Nghệ sĩ', 'Artists'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        for (final ns in dsNgheSi)
          ListTile(
            leading: AvatarNgheSi(ngheSi: ns),
            title: Text(ns.name),
            subtitle: Text(ns.city),
            onTap: () {
              caiDat.themLichSuTim(tuKhoa);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: ns),
                ),
              );
            },
          ),
        if (dsBai.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              tr('Bài hát', 'Tracks'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        for (final bai in dsBai)
          SongTile(
            bai: bai,
            dangChon: baiDangPhat?.id == bai.id,
            onTap: () {
              caiDat.themLichSuTim(tuKhoa);
              phatBai(bai, dsBai);
            },
            trailing: MenuBaiHat(bai: bai),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Tìm kiếm', 'Search'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: TextField(
              controller: _controller,
              onChanged: (giaTri) => setState(() => tuKhoa = giaTri),
              onSubmitted: (giaTri) => caiDat.themLichSuTim(giaTri),
              decoration: InputDecoration(
                hintText: tr(
                  'Tìm bài hát, nghệ sĩ, thể loại...',
                  'Search tracks, artists, genres...',
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: tuKhoa.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => tuKhoa = '');
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: tuKhoa.trim().isEmpty ? manHinhDau() : ketQua(),
          ),
        ],
      ),
    );
  }
}
