import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glyph_notes/const/const.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:glyph_notes/provider/file_manager.dart';
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
  Timer? _debounceTimer;
  final Duration _saveDelay = const Duration(seconds: 2);
  final FileManager _fileManager = FileManager();
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text:  '');
    _titleController = TextEditingController(text:  '');
    _loadNote();
    _initAutoSave();
  }

  void _initAutoSave() {
    _textController.addListener(_onTextChanged);
    _titleController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_saveDelay, _saveNote);
  }

  Future<void> _loadNote() async {
 
  }

  Future<void> _saveNote() async {
    try {
      // final notesBox = Hive.box<Note>(noteBox);
      // await notesBox.put('current_note', Note(
      //   title: _titleController.text,
      //   content: _textController.text,
      //   lastModified: DateTime.now()
      // )
      
      _fileManager.createMarkdownFile("folderName", _titleController.text, _textController.text);
    } catch (e) {
      debugPrint('Error saving note: $e');
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.removeListener(_onTextChanged);
    _titleController.removeListener(_onTextChanged);
    _textController.dispose();
    _titleController.dispose();
    _saveNote(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer:  GlyDrawer(),
      appBar: AppBar(
        title: _buildTitleField(context),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _syncNotes,
            tooltip: 'Sync Notes',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareNote,
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
                    ?Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Markdown(
                          data: _textController.text,
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            p: Theme.of(context).textTheme.bodyLarge,
                            h1: Theme.of(context).textTheme.headlineSmall,
                            code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ):Padding(
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

  Future<void> _syncNotes() async {
    
  }

  Future<void> _shareNote() async {
    
  }
}