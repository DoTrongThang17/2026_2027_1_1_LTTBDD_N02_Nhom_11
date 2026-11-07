import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import '../services/setting_service.dart';
import '../theme/app_theme.dart';

void moAmLuong(BuildContext context) {
  final cacTocDo = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  showModalBottomSheet(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, capNhat) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('Âm lượng', 'Volume'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    amLuong == 0
                        ? Icons.volume_off
                        : Icons.volume_down,
                  ),
                  Expanded(
                    child: Slider(
                      value: amLuong,
                      divisions: 10,
                      activeColor: mauChinh,
                      label: '${(amLuong * 100).round()}%',
                      onChanged: (giaTri) {
                        doiAmLuong(giaTri);
                        capNhat(() {});
                      },
                    ),
                  ),
                  const Icon(Icons.volume_up),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                tr('Tốc độ phát', 'Playback speed'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final td in cacTocDo)
                    ChoiceChip(
                      label: Text('${td}x'),
                      selected: tocDo == td,
                      selectedColor: mauChinh,
                      onSelected: (_) {
                        doiTocDo(td);
                        capNhat(() {});
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
