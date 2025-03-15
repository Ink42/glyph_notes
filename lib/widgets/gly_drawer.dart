import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:glyph_notes/const/const.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/provider/file_manager.dart';
import 'package:provider/provider.dart';

class GlyDrawer extends StatefulWidget {
  const GlyDrawer({super.key});

  @override
  State<GlyDrawer> createState() => _GlyDrawerState();
}

class _GlyDrawerState extends State<GlyDrawer> {
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    try {
      final fileManager = FileManager();
      final files = await fileManager.listFiles('notes');
      
      final notes = await Future.wait(files.whereType<File>().map((file) async {
        final content = await file.readAsString();
        return Note(
          title: path.basenameWithoutExtension(file.path),
          content: content,
          lastModified: await file.lastModified(),
          filePath: file.path,
        );
      }).toList());

      setState(() {
        _notes = notes..sort((a, b) => b.lastModified.compareTo(a.lastModified));
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading notes: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.menu),
                  ),
                  const Text("Notes Drawer", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _createNewNote(context),
                    icon: const Icon(Icons.add),
                    tooltip: 'Create new note',
                  ),
                  IconButton(
                    onPressed: () => _searchNotes(context),
                    icon: const Icon(Icons.search_rounded),
                    tooltip: 'Search notes',
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: _loadNotes,
                        child: ListView.builder(
                          itemCount: _notes.length,
                          itemBuilder: (_, index) {
                            final note = _notes[index];
                            return _buildNoteItem(context, note, screenSize);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteItem(BuildContext context, Note note, Size screenSize) {
    return InkWell(
      onTap: () => _openNote(context, note),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: screenSize.height * 0.06,
        child: Row(
          children: [
            const Icon(Icons.note, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                note.title.isNotEmpty ? note.title : 'Untitled Note',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18),
              onPressed: () => _deleteNote(note, context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewNote(BuildContext context) async {
    final newNote = Note(
      title: 'New Note',
      content: '',
      lastModified: DateTime.now(),
    );

    try {
      final fileManager = FileManager();
      await fileManager.createMarkdownFile(
        'notes', 
        newNote.title, 
        newNote.content
      );
      
      await _loadNotes();
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create note: $e')),
      );
    }
  }

  void _openNote(BuildContext context, Note note) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }

  Future<void> _deleteNote(Note note, BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('This cannot be undone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && note.filePath != null) {
      try {
        final file = File(note.filePath!);
        if (await file.exists()) {
          await file.delete();
          await _loadNotes();  
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note deleted')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete note: $e')),
        );
      }
    }
  }

  void _searchNotes(BuildContext context) {
    showSearch(
      context: context,
      delegate: NotesSearchDelegate(_notes),
    );
  }
}

class NotesSearchDelegate extends SearchDelegate {
  final List<Note> notes;

  NotesSearchDelegate(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = notes.where((note) =>
        note.title.toLowerCase().contains(query.toLowerCase()) ||
        note.content.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final note = results[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(
            note.content.length > 50 
              ? '${note.content.substring(0, 50)}...' 
              : note.content,
          ),
          onTap: () => close(context, note),
        );
      },
    );
  }
}