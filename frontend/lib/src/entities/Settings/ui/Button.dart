import 'package:flutter/material.dart';

import '../../../shared/theme/Theme.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback onTap;
  const SettingsButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context);
    final settingsTheme = theme.settings;
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.more_vert,
        color: settingsTheme.blockColor,
        size: 40,
      ),
    );
  }
}
