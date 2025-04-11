import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:glyph_notes/provider/file_manager.dart';
import 'package:glyph_notes/widgets/gly_drawer.dart';
import 'package:glyph_notes/widgets/options.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class MainPage extends StatefulWidget {
  Note? note;
  MainPage(Note this.note, {super.key});

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
    log("cheking + ${widget.note!.title.toString()} ");
    super.initState();
    _textController = TextEditingController(text: widget.note!.content);
    _titleController = TextEditingController(text: widget.note!.title);
    if (widget.note!.filePath == null) {
      _loadNote();
    }
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

  @override
  Future<void> _loadNote() async {
    try {
      final files = await _fileManager.listFiles('notes');
      if (files.isNotEmpty) {
        files.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified),
        );
        final recentFile = files.first as File;
        final content = await recentFile.readAsString();

        setState(() {
          _textController.text = content;
          _titleController.text = path.basenameWithoutExtension(
            recentFile.path,
          );
        });
      }
    } catch (e) {
      debugPrint('Error loading note: $e');
    }
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty) {
      _titleController.text = 'Untitled ${DateTime.now().toString()}';
    }

    try {
      final fileManager = FileManager();
      final String newTitle = _titleController.text;
      final String newContent = _textController.text;

      if (widget.note?.filePath != null) {
        final oldFile = File(widget.note!.filePath!);
        final oldTitle = path.basenameWithoutExtension(widget.note!.filePath!);

        if (oldTitle != newTitle) {
          if (await oldFile.exists()) {
            await oldFile.delete();
          }
        }
      }

      final newFilePath = await fileManager.createMarkdownFile(
        'notes',
        newTitle,
        newContent,
      );

      widget.note =
          widget.note?.copyWith(
            title: newTitle,
            content: newContent,
            lastModified: DateTime.now(),
            filePath: newFilePath,
          ) ??
          Note(
            title: newTitle,
            content: newContent,
            lastModified: DateTime.now(),
            filePath: newFilePath,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note saved as ${newTitle}.md'),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint('Error saving note: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save note'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _syncNotes() async {}

  Future<void> _shareNote() async {}

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.removeListener(_onTextChanged);
    _titleController.removeListener(_onTextChanged);
    _textController.dispose();
    _titleController.dispose();
    // _saveNote();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlyDrawer(),
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
                    ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Markdown(
                        data: _textController.text,
                        styleSheet: MarkdownStyleSheet.fromTheme(
                          Theme.of(context),
                        ).copyWith(
                          p: Theme.of(context).textTheme.bodyLarge,
                          h1: Theme.of(context).textTheme.headlineSmall,
                          code: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontFamily: 'monospace'),
                        ),
                      ),
                    )
                    : Padding(
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
}
