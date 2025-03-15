import 'dart:io';

import 'package:path/path.dart' as path;


class Note {
  final String title;
  final String content;
  DateTime lastModified;
  String? filePath; 

  Note({
    required this.title,
    required this.content,
    required this.lastModified,
    this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'lastModified': lastModified.toIso8601String(),
      'filePath': filePath,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      lastModified: DateTime.parse(map['lastModified']),
      filePath: map['filePath'],
    );
  }

  factory Note.fromFileContent(String content, String filePath) {
    final lines = content.split('\n');
    final title = path.basenameWithoutExtension(filePath);
    return Note(
      title: title,
      content: content,
      lastModified: File(filePath).lastModifiedSync(),
      filePath: filePath,
    );
  }
}

