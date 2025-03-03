

import 'package:flutter/material.dart';

class GlyDrawer extends StatelessWidget {
  const GlyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
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
                        Navigator.pop(context); 
                      },
                      icon: const Icon(Icons.menu)),
                  const Text("Notes Drawer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(), 
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                ],
              ),
              const Divider(),
              
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      height: screenSize.height*0.06, width: double.infinity,
                    child: Row(
                      spacing: 10,
                      children: [
                      Icon(Icons.folder),
                      Text("note "+index.toString())
                    ],),
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