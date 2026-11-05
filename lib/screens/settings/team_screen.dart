import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

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
        ],
      ),
    );
  }
}
