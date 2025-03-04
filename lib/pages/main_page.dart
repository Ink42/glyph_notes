import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:glyph_notes/widgets/gly_drawer.dart';
import 'package:glyph_notes/widgets/options.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final TextEditingController _textController;
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const GlyDrawer(),
      appBar: AppBar(
        title: _buildTitleField(context),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _syncNotes,
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Notes',
          ),
          IconButton(
            onPressed: _shareNote,
            icon: const Icon(Icons.share),
            tooltip: 'Share Note',
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          const OptionsBar(),
          const Divider(height: 1),
          Expanded(
            child: Consumer<EditerMode>(
              builder: (context, editerMode, _) {
                return editerMode.isEditMode
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _textController,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Start writing your note...',
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Markdown(data: _textController.text),
                      );
              },
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildTitleField(BuildContext context) {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: "Glyph Notes...",
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w200,
          color: Colors.grey.shade600,
        ),
        contentPadding: EdgeInsets.zero,
      ),
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).appBarTheme.titleTextStyle?.color,
      ),
      maxLines: 1,
      textCapitalization: TextCapitalization.words,
    );
  }

  void _syncNotes() {
    // Implement sync functionality
  }

  void _shareNote() {
    // Implement share functionality
  }
}



