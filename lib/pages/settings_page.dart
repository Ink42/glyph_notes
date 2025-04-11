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
        title: const Text("Glyph Notes Settings"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text("Appearance"),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _AppearancePage(),
                    ),
                  ),
            ),
            ListTile(
              title: const Text("View Licenses"),
              onTap:
                  () => showLicensePage(
                    context: context,
                    applicationName: "Glyph Notes",
                    applicationVersion: "1.0.0",
                  ),
            ),
            ListTile(
              title: const Text("Repositories"),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _RepositoryPage(),
                    ),
                  ),
            ),
            ListTile(
              title: const Text("About"),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const _AboutPage()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepositoryPage extends StatefulWidget {
  const _RepositoryPage();

  @override
  _RepositoryPageState createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<_RepositoryPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isVisable = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Repositories")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gemini API-Key",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
              obscureText: _isVisable,
              decoration: InputDecoration(
                hintText: "Enter API key",
                border: const OutlineInputBorder(),
                prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisable = !_isVisable;
                    });
                  },
                  icon: Icon(
                    _isVisable ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppearancePage extends StatelessWidget {
  const _AppearancePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appearance")),
      body: Column(
        children: [
          ListTile(
            title: Text("App Theme"),
            subtitle: Text("Current app theme"),
            trailing: Icon(Icons.nightlight),
          ),
          ListTile(
            title: Text("Font Style"),
            subtitle: Text("Current font style"),
          ),
        ],
      ),
    );
  }
}

class _AboutPage extends StatelessWidget {
  const _AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Glyph Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Glyph Notes",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            const Text("Version: 0.3.6"),
            const SizedBox(height: 10),
            const Text(
              "Glyph Notes is a minimal note-taking app built with Flutter.",
            ),
            const SizedBox(height: 20),
            const Text("Developer: BlankOP "),
            const Text("Contact: BlankOP@gmail.com"),
          ],
        ),
      ),
    );
  }
}
