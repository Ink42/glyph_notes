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
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text("Appearance"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _appearancePage()),
              ),
            ),
            ListTile(
              title: Text("View Licenses"),
              onTap: () => showLicensePage(
                context: context,
                applicationName: "Glyph Notes",
                applicationVersion: "1.0.0",
              ),
            ),
            ListTile(
              title: Text("Repositories"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _repositoryPage()),
              ),
            ),
            ListTile(
              title: Text("About"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _aboutPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _repositoryPage() {
    return Scaffold(
      appBar: AppBar(title: Text("Repositories")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Gemini API-Key"),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter API key",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appearancePage() {
    return Scaffold(
      appBar: AppBar(title: Text("Appearance")),
      body: Center(child: Text("Appearance settings go here.")),
    );
  }

  Widget _aboutPage() {
    return Scaffold(
      appBar: AppBar(title: Text("About Glyph Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Glyph Notes", style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 10),
            Text("Version: 0.3.6"),
            SizedBox(height: 10),
            Text("Glyph Notes is a minimal note-taking app built with Flutter."),
            SizedBox(height: 20),
            Text("Developer: BlankOP "),
            Text("Contact: BlankOP@gmail.com"),
          ],
        ),
      ),
    );
  }
}
