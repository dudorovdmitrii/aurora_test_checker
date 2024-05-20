import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class LanguageRadio extends StatelessWidget {
  const LanguageRadio({super.key});

  @override
  Widget build(BuildContext context) => ScarlettLocalization(
        builder: (locale) => Column(
          children: <Widget>[
            ListTile(
              title: const Text('Русский'),
              leading: Radio<String>(
                value: 'Русский',
                groupValue: S.of(context).localeFull,
                onChanged: (String? value) async {
                  await ScarlettLocalization.switchLocaleOf(context);
                },
              ),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio<String>(
                value: 'English',
                groupValue: S.of(context).localeFull,
                onChanged: (String? value) async {
                  await ScarlettLocalization.switchLocaleOf(context);
                },
              ),
            ),
          ],
        ),
      );
}
