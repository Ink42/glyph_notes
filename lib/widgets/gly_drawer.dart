// import 'package:flutter/material.dart';
// import 'package:glyph_notes/const/const.dart';
// import 'package:glyph_notes/model/note_model.dart';
// import 'package:glyph_notes/pages/main_page.dart'; // Import your main page
// import 'package:hive_flutter/hive_flutter.dart';

// class GlyDrawer extends StatelessWidget {
//   GlyDrawer({super.key});
//   final notesBox = Hive.box<Note>(noteBox);

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.sizeOf(context);
//     return Drawer(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.menu),
//                   ),
//                   const Text("Notes Drawer", 
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () => _createNewNote(context),
//                     icon: const Icon(Icons.add),
//                     tooltip: 'Create new note',
//                   ),
//                   IconButton(
//                     onPressed: () => _searchNotes(context),
//                     icon: const Icon(Icons.search_rounded),
//                     tooltip: 'Search notes',
//                   ),
//                 ],
//               ),
//               const Divider(),
//               Expanded(
//                 child: ValueListenableBuilder(
//                   valueListenable: notesBox.listenable(),
//                   builder: (context, Box<Note> box, _) {
//                     return ListView.builder(
//                       itemCount: box.length,
//                       itemBuilder: (_, index) {
//                         final note = box.getAt(index);
//                         return note != null
//                             ? _buildNoteItem(context, note, screenSize)
//                             : const SizedBox();
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNoteItem(BuildContext context, Note note, Size screenSize) {
//     return InkWell(
//       onTap: () => _openNote(context, note),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         height: screenSize.height * 0.06,
//         child: Row(
//           children: [
//             const Icon(Icons.note, size: 20),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 note.title.isNotEmpty ? note.title : 'Untitled Note',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, size: 18),
//               onPressed: () => _deleteNote(note, context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _createNewNote(BuildContext context) {
//     final newNote = Note(
//       title: 'New Note',
//       content: '',
//       lastModified: DateTime.now(),
//     );

//     notesBox.add(newNote).then((_) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainPage(initialNote: newNote),
//         ),
//       );
//     });
//   }

//   void _openNote(BuildContext context, Note note) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MainPage(initialNote: note),
//       ),
//     );
//   }

// void _deleteNote(Note note, context) async {
//   final confirmed = await showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Delete Note?'),
//       content: const Text('This cannot be undone'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: const Text('Delete'),
//         ),
//       ],
//     ),
//   );

//   if (confirmed == true) {
//     // Delete logic
//   }
// }

//   void _searchNotes(BuildContext context) {
//     showSearch(
//       context: context,
//       delegate: NotesSearchDelegate(notesBox.values.toList()),
//     );
//   }
// }

// class NotesSearchDelegate extends SearchDelegate {
//   final List<Note> notes;

//   NotesSearchDelegate(this.notes);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () => query = '',
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => close(context, null),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return _buildSearchResults();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return _buildSearchResults();
//   }

//   Widget _buildSearchResults() {
//     final results = notes.where((note) =>
//         note.title.toLowerCase().contains(query.toLowerCase()) ||
//         note.content.toLowerCase().contains(query.toLowerCase())).toList();

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final note = results[index];
//         return ListTile(
//           title: Text(note.title),
//           subtitle: Text(
//             note.content.length > 50 
//               ? '${note.content.substring(0, 50)}...' 
//               : note.content,
//           ),
//           onTap: () => close(context, note),
//         );
//       },
//     );
//   }
// }