import 'package:flutter/material.dart';

import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: Icon(
              caiDat.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: mauChinh,
            ),
            title: Text(
              caiDat.themeMode == ThemeMode.dark
                  ? 'Giao diện tối'
                  : 'Giao diện sáng',
            ),
            value: caiDat.themeMode == ThemeMode.dark,
            onChanged: (bat) => caiDat.doiCheDoToi(bat),
          ),
        ],
      ),
    );
  }
}
