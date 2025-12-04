import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.onTapped,
  });

  final ColorScheme colorScheme;
  final String title, subtitle, iconPath;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Material(
        color: transparentClr,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTapped,
          child: ListTile(
            tileColor: colorScheme.surfaceContainerHigh,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: colorScheme.surfaceContainerLowest),
            ),
            leading: CircleAvatar(
              backgroundColor: colorScheme.surfaceContainerLowest,
              child: customSvg(path: iconPath, colorScheme: colorScheme),
            ),
            title: BuildText(text: title, textSize: 14),
            subtitle: BuildText(text: subtitle, textSize: 12),
            trailing: customSvg(
              path: "right",
              colorScheme: colorScheme,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}
