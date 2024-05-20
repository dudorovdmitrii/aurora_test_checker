import 'package:flutter/material.dart';

import '../../../shared/theme/Theme.dart';

class PhotoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const PhotoButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context).settings;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.blockColor,
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
      ),
    );
  }
}
