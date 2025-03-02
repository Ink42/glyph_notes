

import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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

    );
  }



}
class GlyDrawer extends StatelessWidget {
  const GlyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Closes the drawer
                      },
                      icon: const Icon(Icons.menu)),
                  const Text("Notes Drawer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(), // Pushes icons to the right
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                ],
              ),
              const Divider(),
              // Wrapped in Expanded to prevent height issues
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text("Note ${index + 1}"),
                      onTap: () {
                        // Handle note selection
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}