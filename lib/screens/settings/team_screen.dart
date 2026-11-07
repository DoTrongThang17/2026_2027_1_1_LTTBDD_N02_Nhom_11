import 'package:flutter/material.dart';

import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  final List<Map<String, String>> thanhVien = const [
    {
      'ten': 'Đỗ Trọng Thắng',
      'msv': '24100316',
      'vaiTro': 'Nhóm trưởng',
    },
    {
      'ten': 'Nguyễn Anh Tuấn',
      'msv': '24100400',
      'vaiTro': 'Thành viên',
    },
    {
      'ten': 'Nguyễn Thế Tuấn',
      'msv': '24100315',
      'vaiTro': 'Thành viên',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Thông tin nhóm', 'Team info'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [mauChinh, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.graphic_eq,
                  color: Colors.white,
                  size: 48,
                ),
                const Text(
                  'Nhóm 11',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  tr(
                    'Ứng dụng nghe nhạc lấy cảm hứng từ SoundCloud',
                    'A music app inspired by SoundCloud',
                  ),
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(tr('Trường', 'University')),
                  subtitle: const Text('Đại học Phenikaa'),
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(tr('Môn học', 'Course')),
                  subtitle: Text(
                    tr(
                      'Lập trình cho thiết bị di động',
                      'Mobile Programming',
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: Text(tr('Lớp - Nhóm', 'Class - Group')),
                  subtitle: const Text('N02 - Nhóm 11'),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(tr('Giảng viên', 'Lecturer')),
                  subtitle: const Text('Nguyễn Xuân Quế'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              tr('Thành viên', 'Members'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (final tv in thanhVien)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: mauChinh,
                  foregroundColor: Colors.white,
                  child: Text(tv['ten']![0]),
                ),
                title: Text(tv['ten']!),
                subtitle: Text('MSV: ${tv['msv']}'),
                trailing: Text(tv['vaiTro']!),
              ),
            ),
        ],
      ),
    );
  }
}
