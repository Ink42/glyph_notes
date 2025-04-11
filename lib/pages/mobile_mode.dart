import 'package:flutter/material.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/main_page.dart';

class MobileMode extends StatefulWidget {
  const MobileMode({super.key});

  @override
  State<MobileMode> createState() => _MobileModeState();
}

class _MobileModeState extends State<MobileMode> {
  @override
  Widget build(BuildContext context) =>
      MainPage(Note(title: "", content: "", lastModified: DateTime.now()));
}
