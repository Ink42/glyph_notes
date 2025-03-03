import 'package:flutter/material.dart';
import 'package:glyph_notes/const/const.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(FolderAdapter());
  
  await Hive.openBox<Note>(noteBox);
  await Hive.openBox<Folder>(foldersBox);
  runApp(
    MultiProvider(providers: [
      // Provider<EditerMode>(create: (_) => EditerMode()),
      ChangeNotifierProvider<EditerMode>(create: (_)=>EditerMode())
    ]
    ,child: MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: MainPage(),
    );
  }
}
