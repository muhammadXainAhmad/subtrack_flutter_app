import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class AddSubscriptionDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool isEnabled;
  final void Function(String?)? onChanged;
  final String? selectedItem;
  final String path1;
  final String path2;

  const AddSubscriptionDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.isEnabled,
    this.selectedItem,
    this.onChanged,
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
        Opacity(
          opacity: isEnabled ? 1 : 0.5,
          child: DropdownMenu(
            enabled: isEnabled,
            key: ValueKey("${title}_${items.hashCode}_${selectedItem ?? ''}"),
            initialSelection: selectedItem,
            onSelected: (value) {
              if (onChanged != null) onChanged!(value);
            },
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: colorScheme.surfaceContainerLowest,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: colorScheme.surfaceContainerLowest,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: colorScheme.surfaceContainerLowest,
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
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
