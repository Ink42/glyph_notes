import 'package:flutter/material.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:provider/provider.dart';

class OptionsBar extends StatelessWidget {
  const OptionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => _openFolder(context),
            icon: const Icon(Icons.folder_outlined),
            tooltip: 'Open Folder',
          ),
          IconButton(
            onPressed: () => _toggleFavorite(context),
            icon: const Icon(Icons.star_border_rounded),
            tooltip: 'Add to Favorites',
          ),
          IconButton(
            onPressed: () => _addLink(context),
            icon: const Icon(Icons.add_link_sharp),
            tooltip: 'Add Link',
          ),
          Consumer<EditerMode>(
            builder: (context, editerMode, _) {
              return Switch(
                value: editerMode.isEditMode,
                onChanged: (value) => editerMode.toggleMode(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openFolder(BuildContext context) {
    // Implement folder opening
  }

  void _toggleFavorite(BuildContext context) {
    // Implement favorite toggle
  }

  void _addLink(BuildContext context) {
    // Implement link insertion
  }
}