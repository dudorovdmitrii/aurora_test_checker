import 'package:flutter/material.dart';

import '../../../shared/theme/Theme.dart';
import '../../../shared/theme/ThemeModes.dart';

class ThemeRadio extends StatelessWidget {
  final TopGMode themeMode;
  const ThemeRadio({required this.themeMode, super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            title: const Text('Light'),
            leading: Radio<TopGMode>(
              value: TopGMode.light,
              groupValue: themeMode,
              onChanged: (TopGMode? value) async {
                await TopG.toggleThemeOf(context);
              },
            ),
          ),
          ListTile(
            title: const Text('Dark'),
            leading: Radio<TopGMode>(
              value: TopGMode.dark,
              groupValue: themeMode,
              onChanged: (TopGMode? value) async {
                await TopG.toggleThemeOf(context);
              },
            ),
          ),
        ],
      );
}
