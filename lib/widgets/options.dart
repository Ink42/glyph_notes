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
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
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
                  IconButton(
                  onPressed: () => _addLink(context),
                  icon: const Icon(Icons.format_list_bulleted),
                  tooltip: 'bullet format',
                ),
                 IconButton(
                  onPressed: () => _addLink(context),
                  icon: const Icon(Icons.format_italic_rounded),
                  tooltip: 'italic',
                ),
                    IconButton(
                  onPressed: () => _addLink(context),
                  icon: const Icon(Icons.format_bold_rounded),
                  tooltip: 'Bold',
                ),    
                IconButton(
                  onPressed: () => _addLink(context),
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                ),
                /// Have a purpose
                Icon(null),
                Icon(null),
                Icon(null),

              ],
            ),
          ),
              Consumer<EditerMode>(
                  builder: (context, editerMode, _) {
                    return Align(
alignment: Alignment.centerRight,
                      child: Container(
                        width: 100,
                        color: Colors.red,
                        child: Switch(
                          value: editerMode.isEditMode,
                          onChanged: (value) => editerMode.toggleMode(),
                        ),
                      ),
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
  
  }
}