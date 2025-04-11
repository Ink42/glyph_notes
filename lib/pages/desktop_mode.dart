import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DesktopMode extends StatefulWidget {
  DesktopMode({super.key});

  @override
  State<DesktopMode> createState() => _DesktopModeState();
}

class _DesktopModeState extends State<DesktopMode> {
  TextEditingController _textController = TextEditingController();
  double leftFlex = 2;
  double centerFlex = 4;
  double rightFlex = 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Icon(Icons.edit_document, color: Colors.blue),
                SizedBox(width: 8), // Add spacing manually
                Text(
                  "Glyph Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [MaterialButton(onPressed: () {}, child: Text("New"))],
          ),
          body: Row(
            children: [
              Expanded(flex: leftFlex.round(), child: Files()),

              // Divider 1
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    double delta = details.delta.dx / constraints.maxWidth * 10;
                    leftFlex += delta;
                    centerFlex -= delta;
                    if (leftFlex < 1) leftFlex = 1;
                    if (centerFlex < 1) centerFlex = 1;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: Container(width: 2, color: Colors.grey),
                ),
              ),

              Expanded(
                flex: centerFlex.round(),
                child: MarkDownEditor(controller: _textController),
              ),

              // Divider 2
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    double delta = details.delta.dx / constraints.maxWidth * 10;
                    centerFlex += delta;
                    rightFlex -= delta;
                    if (centerFlex < 1) centerFlex = 1;
                    if (rightFlex < 1) rightFlex = 1;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: Container(width: 2, color: Colors.grey),
                ),
              ),

              Expanded(
                flex: rightFlex.round(),
                child: Preview(controller: _textController),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Files extends StatelessWidget {
  Files({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.blue,

              borderRadius: BorderRadius.circular(12),
            ),
            height: 50,
            width: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: null,
                  label: Text("data"),
                  icon: Icon(Icons.document_scanner),
                ),
                Text("Apr 7"),
                Icon(Icons.more_vert),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MarkDownEditor extends StatelessWidget {
  final TextEditingController controller;
  const MarkDownEditor({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Start writing your note...',
        ),
        onChanged: (_) {
          // Trigger rebuild of parent so the Preview updates (if needed)
          (context as Element).markNeedsBuild();
        },
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final TextEditingController controller;
  const Preview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: controller.text,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: Theme.of(context).textTheme.bodyLarge,
        h1: Theme.of(context).textTheme.headlineSmall,
        code: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
      ),
    );
  }
}
