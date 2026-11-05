import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  final List> thanhVien = const [
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
      appBar: AppBar(
        title: const Text('Thông tin nhóm'),
      ),
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
            child: const Column(
              children: [
                Icon(
                  Icons.graphic_eq,
                  color: Colors.white,
                  size: 48,
                ),
                Text(
                  'Nhóm 11',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ứng dụng nghe nhạc lấy cảm hứng từ SoundCloud',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Trường'),
                  subtitle: Text('Đại học Phenikaa'),
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Môn học'),
                  subtitle: Text('Lập trình cho thiết bị di động'),
                ),
                ListTile(
                  leading: Icon(Icons.class_),
                  title: Text('Lớp - Nhóm'),
                  subtitle: Text('N02 - Nhóm 11'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Giảng viên'),
                  subtitle: Text('Nguyễn Xuân Quế'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Thành viên',
              style: TextStyle(
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