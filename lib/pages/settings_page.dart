


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Glyph Notes Settings"),
      ),
      body: SafeArea(child: Column(
        children: [
          ListTile(title: Text("Appearance")),
          ListTile(title: Text("View Licenses")),
          ListTile(title: Text("Repositories")),
          ListTile(title: Text("About"))
        ],
      )),
    );
  }
}