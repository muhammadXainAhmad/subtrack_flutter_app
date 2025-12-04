import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.bgClr,
    this.textClr,
    this.textSize,
    this.isCenter = false,
    this.onTap,
    this.actions,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String text;
  final Color? bgClr;
  final double? textSize;
  final Color? textClr;
  final bool? isCenter;
  final VoidCallback? onTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: bgClr ?? colorScheme.surfaceContainer,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: customSvg(path: "left", colorScheme: colorScheme, width: 32),
      ),
      centerTitle: isCenter,
      title: GestureDetector(
        onTap: onTap,
        child: BuildText(
          text: text,
          textSize: textSize ?? 20,
          textClr: textClr,
          textWeight: FontWeight.w700,
        ),
      ),
      actions: actions,
    );
  }
}
