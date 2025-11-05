import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class AddSubscriptionDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> items;
  final String title;
  final String path1;
  final String path2;
  const AddSubscriptionDropdown({
    super.key,
    required this.controller,
    required this.items,
    required this.title,
    required this.path1,
    required this.path2,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenH = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildText(text: title, textSize: 16),
        const SizedBox(height: 10),
        DropdownMenu(
          onSelected: (plan) {},
          enableSearch: true,
          requestFocusOnTap: true,
          enableFilter: true,
          expandedInsets: EdgeInsets.zero,
          trailingIcon: customSvg(path: path1, colorScheme: colorScheme),
          selectedTrailingIcon: customSvg(
            path: path2,
            colorScheme: colorScheme,
          ),
          textStyle: TextStyle(color: colorScheme.onSurface, fontSize: 15),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: colorScheme.surfaceContainerLowest),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: colorScheme.surfaceContainerLowest,
                width: 1.5,
              ),
            ),
          ),
          menuHeight: screenH * 0.5,
          menuStyle: MenuStyle(
            side: WidgetStatePropertyAll(
              BorderSide(color: colorScheme.surfaceContainerLowest),
            ),
            backgroundColor: WidgetStatePropertyAll(
              colorScheme.surfaceContainerHigh,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          dropdownMenuEntries:
              items
                  .map((item) => DropdownMenuEntry(value: item, label: item))
                  .toList(),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
