import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glyph_notes/const/const.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/pages/page_layout_controller.dart';
import 'package:glyph_notes/pages/settings_page.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:glyph_notes/provider/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EditerMode>(create: (_) => EditerMode()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider _themeController = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode:
          _themeController.fetchCanOverrideTheme() ? ThemeMode.system : null,
      theme:
          _themeController.fetchCanOverrideTheme()
              ? _themeController.fetchTheme()
                  ? ThemeData.dark()
                  : ThemeData.light()
              : null,
      home: PageLayoutController(),
    );
  }
}
