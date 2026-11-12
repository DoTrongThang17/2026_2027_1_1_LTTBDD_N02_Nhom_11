import 'package:flutter/material.dart';

import '../../services/data_service.dart';
import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/anh_bia.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tenController = TextEditingController();

  final Map<String, int> fileMau = {
    'mua_tren_pho_co.mp3': 76,
    'neon_ha_noi.mp3': 79,
    'song_vo.mp3': 66,
  };

  final List<Color> dsMau = [
    mauChinh,
    Colors.indigo,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.green,
    Colors.brown,
  ];

  String fileDaChon = 'mua_tren_pho_co.mp3';
  String theLoai = DataService.theLoai[0];
  Color mauBia = mauChinh;
  bool riengTu = false;

  @override
  void dispose() {
    _tenController.dispose();
    super.dispose();
  }

  void _taiLen() {
    if (!_formKey.currentState!.validate()) return;
    duLieu.taiLenBai(
      tenBai: _tenController.text.trim(),
      theLoai: theLoai,
      audio: 'assets/audio/$fileDaChon',
      thoiLuong: Duration(seconds: fileMau[fileDaChon]!),
      mau: mauBia,
      riengTu: riengTu,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          tr('Tải lên thành công! 🎉', 'Upload complete! 🎉'),
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Tải lên bài hát', 'Upload a track')),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: AnhBia(mau: mauBia, kichThuoc: 120, boGoc: 12),
            ),
            const SizedBox(height: 16),

            Text(
              tr('Màu ảnh bìa', 'Cover colour'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                for (final mau in dsMau)
                  GestureDetector(
                    onTap: () => setState(() => mauBia = mau),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: mau,
                      child: mau == mauBia
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _tenController,
              decoration: InputDecoration(
                labelText: tr('Tên bài hát', 'Track title'),
                border: const OutlineInputBorder(),
              ),
              validator: (giaTri) {
                if (giaTri == null || giaTri.trim().isEmpty) {
                  return tr(
                    'Vui lòng nhập tên bài hát',
                    'Please enter a title',
                  );
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Text(
              tr('File nhạc', 'Audio file'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: fileDaChon,
              items: [
                for (final ten in fileMau.keys)
                  DropdownMenuItem(value: ten, child: Text(ten)),
              ],
              onChanged: (giaTri) =>
                  setState(() => fileDaChon = giaTri!),
            ),
            const SizedBox(height: 16),

            Text(
              tr('Thể loại', 'Genre'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: theLoai,
              items: [
                for (final tl in DataService.theLoai)
                  DropdownMenuItem(value: tl, child: Text(tl)),
              ],
              onChanged: (giaTri) =>
                  setState(() => theLoai = giaTri!),
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(tr('Riêng tư', 'Private')),
              subtitle: Text(
                riengTu
                    ? tr(
                        'Chỉ mình bạn nghe được',
                        'Only you can listen',
                      )
                    : tr(
                        'Mọi người đều nghe được',
                        'Everyone can listen',
                      ),
              ),
              value: riengTu,
              onChanged: (giaTri) => setState(() => riengTu = giaTri),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mauChinh,
                  foregroundColor: Colors.white,
                ),
                onPressed: _taiLen,
                icon: const Icon(Icons.cloud_upload),
                label: Text(tr('Tải lên', 'Upload')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
