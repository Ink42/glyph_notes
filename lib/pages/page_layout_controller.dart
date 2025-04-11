import 'package:flutter/material.dart';
import 'package:glyph_notes/model/note_model.dart';
import 'package:glyph_notes/pages/desktop_mode.dart';
import 'package:glyph_notes/pages/main_page.dart';
import 'package:glyph_notes/pages/mobile_mode.dart';

class PageLayoutController extends StatelessWidget {
  const PageLayoutController({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    bool isTablet =
        MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 850;
    bool isPhone = MediaQuery.of(context).size.width < 850;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isPhone) {
          return MobileMode();
        }

        return DesktopMode();
      },
    );
  }
}
