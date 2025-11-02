import 'package:flutter/material.dart';

class ColorSchemePreview extends StatelessWidget {
  const ColorSchemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Each color name and its actual color
    final entries = {
      // Main brand color (buttons, highlights, app bar)
      'primary': scheme.primary,
      // Text/icons on top of primary color
      'onPrimary': scheme.onPrimary,
      // Secondary accent color for less prominent elements
      'secondary': scheme.secondary,
      // Text/icons on top of secondary color
      'onSecondary': scheme.onSecondary,
      // Supportive accent color (used sparingly for visuals)
      'tertiary': scheme.tertiary,
      // Error color (validation errors, delete actions)
      'error': scheme.error,
      // Base background for screens and surfaces
      'surface': scheme.surface,
      // Text/icons drawn on surface color
      'onSurface': scheme.onSurface,
      // Slightly elevated surface (cards, containers)
      'surfaceContainer': scheme.surfaceContainer,
      // Higher elevated surface (modals, floating cards)
      'surfaceContainerHigh': scheme.surfaceContainerHigh,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Scheme Preview'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:
            entries.entries.map((e) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 60,
                decoration: BoxDecoration(
                  color: e.value,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade700, width: 0.5),
                ),
                child: Center(
                  child: Text(
                    e.key,
                    style: TextStyle(
                      color: _getReadableTextColor(e.value),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  // Helps ensure the text stays visible on both light/dark colors
  Color _getReadableTextColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
