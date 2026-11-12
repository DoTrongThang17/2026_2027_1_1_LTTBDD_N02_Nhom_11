import 'dart:async';

import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import '../services/data_service.dart';
import '../services/setting_service.dart';
import '../widgets/mini_player.dart';
import 'feed/feed_screen.dart';
import 'home/home_screen.dart';
import 'library/library_screen.dart';
import 'search/search_screen.dart';
import 'settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tabHienTai = 0;
  StreamSubscription? _theoDoiMayPhat;

  @override
  void initState() {
    super.initState();

    duLieu.addListener(_capNhat);
    caiDat.addListener(_capNhat);
    _theoDoiMayPhat = mayPhat.playerStateStream.listen(
      (_) => _capNhat(),
    );
  }

  void _capNhat() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    duLieu.removeListener(_capNhat);
    caiDat.removeListener(_capNhat);
    _theoDoiMayPhat?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cacTab = [
      HomeScreen(),
      FeedScreen(),
      SearchScreen(),
      LibraryScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: tabHienTai, children: cacTab),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          BottomNavigationBar(
            currentIndex: tabHienTai,
            onTap: (i) => setState(() => tabHienTai = i),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: tr('Trang chủ', 'Home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.dynamic_feed),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: tr('Tìm kiếm', 'Search'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.library_music),
                label: tr('Thư viện', 'Library'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: tr('Cài đặt', 'Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
