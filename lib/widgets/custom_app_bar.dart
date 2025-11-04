import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorScheme.surfaceContainer,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: customSvg(path: "left", colorScheme: colorScheme, width: 32),
      ),
      title: BuildText(text: text, textSize: 20, textWeight: FontWeight.w700),
    );
  }
}
