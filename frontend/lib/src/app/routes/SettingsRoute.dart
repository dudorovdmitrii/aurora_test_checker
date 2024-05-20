import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import '../../features/SettingsActions/ui/LanguageRadio.dart';
import '../../features/SettingsActions/ui/SettingsActions.dart';
import '../../features/SettingsActions/ui/ThemeRadio.dart';
import '../../shared/theme/Theme.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context);
    final settingsTheme = theme.settings;

    return Scaffold(
        backgroundColor: settingsTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: settingsTheme.backgroundColor,
          title: Text(S.of(context).settings),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                const Text('Theme', style: TextStyle(fontSize: 18)),
                ThemeRadio(
                  themeMode: theme.mode,
                ),
                Text(S.of(context).language,
                    style: const TextStyle(fontSize: 18)),
                const LanguageRadio(),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
            SettingsActionsActions()
          ],
        ));
  }
}
