



import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:glyph_notes/model/note_model.dart';

class Folder {
  final String name;
  final List<Note> notes;
  String? folderPath; 

  Folder({
    required this.name,
    required this.notes,
    this.folderPath,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'notes': notes.map((note) => note.toMap()).toList(),
      'folderPath': folderPath,
    };
  }

 
  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      name: map['name'] ?? '',
      notes: (map['notes'] as List).map((e) => Note.fromMap(e)).toList(),
      folderPath: map['folderPath'],
    );
  }

  
  static Future<Folder> fromDirectory(Directory dir) async {
    final files = await dir.list().where((f) => f is File).toList();
    final notes = await Future.wait(
      files.map((file) async {
        final content = await File(file.path).readAsString();
        return Note.fromFileContent(content, file.path);
      }),
    );

    return Folder(
      name: path.basename(dir.path),
      notes: notes,
      folderPath: dir.path,
    );
  }
}