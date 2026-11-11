import 'package:flutter/material.dart';

import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../widgets/anh_bia.dart';
import '../../widgets/menu_bai_hat.dart';
import '../../widgets/song_tile.dart';
import '../artist/artist_screen.dart';

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

  Widget ketQua() {
    final dsBai = duLieu.timKiem(tuKhoa);
    final dsNgheSi = duLieu.timNgheSi(tuKhoa);

    if (dsBai.isEmpty && dsNgheSi.isEmpty) {
      return const Center(child: Text('Không tìm thấy kết quả'));
    }

    return ListView(
      children: [
        if (dsNgheSi.isNotEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Nghệ sĩ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        for (final ns in dsNgheSi)
          ListTile(
            leading: AvatarNgheSi(ngheSi: ns),
            title: Text(ns.name),
            subtitle: Text(ns.city),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtistScreen(ngheSi: ns),
                ),
              );
            },
          ),
        if (dsBai.isNotEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Bài hát',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        for (final bai in dsBai)
          SongTile(
            bai: bai,
            dangChon: baiDangPhat?.id == bai.id,
            onTap: () => phatBai(bai, dsBai),
            trailing: MenuBaiHat(bai: bai),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm')),
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
              decoration: InputDecoration(
                hintText: 'Tìm bài hát, nghệ sĩ, thể loại...',
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
            child: tuKhoa.trim().isEmpty
                ? const SizedBox.shrink()
                : ketQua(),
          ),
        ],
      ),
    );
  }
}
