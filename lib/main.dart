import 'package:flutter/material.dart';

import 'screens/main_screen.dart';
import 'services/audio_service.dart';
import 'services/setting_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  khoiTaoAudio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: caiDat,
      builder: (context, _) {
        return MaterialApp(
          title: 'Nhóm 11',
          debugShowCheckedModeBanner: false,
          theme: taoTheme(),
          darkTheme: taoThemeToi(),
          themeMode: caiDat.themeMode,
          home: const MainScreen(),
        );
      },
    );
  }
}
