import 'package:flutter/material.dart';
import 'package:glyph_notes/model/note_model.dart';

class NoteProvider with ChangeNotifier {
  Note? _currentNote;
  
  Note? get currentNote => _currentNote;
  
  void setCurrentNote(Note note) {
    _currentNote = note;
    notifyListeners();
  }
  
  
  Future<void> saveCurrentNote(String title, String content) async {
    if (_currentNote != null) {
      _currentNote as Note;
      _currentNote = _currentNote!.copyWith(
        title: title,
        content: content,
        lastModified: DateTime.now(),
      );
      notifyListeners();
    }
  }
  
}