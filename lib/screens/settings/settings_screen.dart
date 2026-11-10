import 'package:flutter/material.dart';

import '../../services/setting_service.dart';
import '../../theme/app_theme.dart';
import 'team_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Cài đặt', 'Settings'))),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: mauChinh),
            title: Text(tr('Ngôn ngữ', 'Language')),
            trailing: DropdownButton<String>(
              value: caiDat.ngonNgu,
              items: const [
                DropdownMenuItem(
                  value: 'vi',
                  child: Text('Tiếng Việt'),
                ),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: (giaTri) => caiDat.doiNgonNgu(giaTri!),
            ),
          ),
          SwitchListTile(
            secondary: Icon(
              caiDat.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: mauChinh,
            ),

            title: Text(
              caiDat.themeMode == ThemeMode.dark
                  ? tr('Giao diện tối', 'Dark mode')
                  : tr('Giao diện sáng', 'Light mode'),
            ),
            value: caiDat.themeMode == ThemeMode.dark,
            onChanged: (bat) => caiDat.doiCheDoToi(bat),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group, color: mauChinh),
            title: Text(tr('Thông tin nhóm', 'Team info')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TeamScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
