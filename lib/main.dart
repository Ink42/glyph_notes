import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glyph_notes/const/const.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/provider/editer_mode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();



  runApp(
    
    MultiProvider(providers: [
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
    DirectoryVerify();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: MainPage(),
    );
  }

  void DirectoryVerify() async
  {
    // final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    
    // log(appDocumentsDir.list().toList().toString());
    
    
  
  }



}
