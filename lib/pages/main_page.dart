

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:glyph_notes/widgets/gly_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
bool view =false;
TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlyDrawer(),
      appBar: AppBar(
        title: Text("Glyph Notes"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.hub)),
          IconButton(onPressed: null, icon: Icon(Icons.hub)),
        ],
      ),

      body: Column(children: [
Divider(),
Row(children: [
  IconButton(onPressed: (){}, icon: Icon(Icons.folder_outlined)),
  IconButton(onPressed: (){}, icon: Icon(Icons.star_border_rounded)),
  IconButton(onPressed: (){}, icon: Icon(Icons.add_link_sharp)),
  CupertinoSwitch(value: view, onChanged: (val)=> setState(()=>view =!view))
  ,
  
],),
Divider()
,
 Expanded(
            child: view
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Start writing your note...',
                      ),
                    ),
                  )
                :  Markdown(data: _textController.text))
          


      ],),




    );
  }
}
