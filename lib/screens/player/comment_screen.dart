import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../services/audio_service.dart';
import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dinh_dang.dart';

class CommentScreen extends StatefulWidget {
  final Song bai;
  const CommentScreen({super.key, required this.bai});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _gui() {
    final noiDung = _controller.text.trim();
    if (noiDung.isEmpty) return;

    final thoiDiem = baiDangPhat?.id == widget.bai.id
        ? mayPhat.position
        : Duration.zero;
    duLieu.themBinhLuan(widget.bai, noiDung, thoiDiem);
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ds = duLieu.binhLuanCua(widget.bai);
    return Scaffold(
      appBar: AppBar(
        title: Text('${tr('Bình luận', 'Comments')} (${ds.length})'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ds.isEmpty
                ? Center(
                    child: Text(
                      tr('Chưa có bình luận nào', 'No comments yet'),
                    ),
                  )
                : ListView(
                    children: [
                      for (final bl in ds)
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: bl.mau,
                            child: Text(
                              bl.nguoiViet[0],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            bl.nguoiViet,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(bl.noiDung),
                          trailing: Text(
                            doiThoiGian(bl.thoiDiem),
                            style: const TextStyle(color: mauChinh),
                          ),
                        ),
                    ],
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _gui(),
                      decoration: InputDecoration(
                        hintText: tr(
                          'Viết bình luận...',
                          'Write a comment...',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: mauChinh),
                    onPressed: _gui,
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
