import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String title;

  @HiveField(1) 
  final String content;

  Note({required this.title, required this.content});
}

@HiveType(typeId: 1)
class Folder {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<Note> notes;

  Folder({required this.name, required this.notes});
}