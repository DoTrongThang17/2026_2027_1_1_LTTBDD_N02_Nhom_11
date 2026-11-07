import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import '../services/setting_service.dart';
import '../theme/app_theme.dart';

String gioPhut(DateTime t) {
  final gio = t.hour.toString().padLeft(2, '0');
  final phut = t.minute.toString().padLeft(2, '0');
  return '$gio:$phut';
}

void moHenGio(BuildContext context, VoidCallback xong) {
  final cacMoc = [1, 15, 30, 45, 60];
  showModalBottomSheet(
    context: context,
    builder: (ctx) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              tr('Hẹn giờ tắt nhạc', 'Sleep timer'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (gioTat != null)
            ListTile(
              leading: const Icon(Icons.alarm_on, color: mauChinh),
              title: Text(
                tr(
                  'Nhạc sẽ tắt lúc ${gioPhut(gioTat!)}',
                  'Music stops at ${gioPhut(gioTat!)}',
                ),
              ),
            ),
          for (final phut in cacMoc)
            ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: Text(tr('$phut phút', '$phut min')),
              onTap: () {
                henGioTat(phut);
                Navigator.pop(ctx);
                xong();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      tr(
                        'Nhạc sẽ tắt sau $phut phút',
                        'Music will stop in $phut min',
                      ),
                    ),
                  ),
                );
              },
            ),
          if (gioTat != null)
            ListTile(
              leading: const Icon(Icons.alarm_off, color: Colors.red),
              title: Text(tr('Tắt hẹn giờ', 'Turn off timer')),
              onTap: () {
                huyHenGio();
                Navigator.pop(ctx);
                xong();
              },
            ),
        ],
      ),
    ),
  );
}
