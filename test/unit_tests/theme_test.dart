import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glyph_notes/provider/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('Initial theme is light (false) and can override is true', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.fetchTheme(), false);
      expect(themeProvider.fetchCanOverrideTheme(), true);
    });

    group('toggleTheme', () {
      test('toggles theme to dark (true) if can override is true', () {
        final themeProvider = ThemeProvider();
        expect(themeProvider.fetchCanOverrideTheme(), true);
        themeProvider.toggleTheme();
        expect(themeProvider.fetchTheme(), true);
      });

      test('toggles theme back to light (false) if can override is true', () {
        final themeProvider = ThemeProvider();
        expect(themeProvider.fetchCanOverrideTheme(), true);
        // Toggle to dark first
        themeProvider.toggleTheme();
        expect(themeProvider.fetchTheme(), true);
        // Toggle back to light
        themeProvider.toggleTheme();
        expect(themeProvider.fetchTheme(), false);
      });

      test('does not toggle theme if can override is false', () {
        final themeProvider = ThemeProvider();
        themeProvider.toggleCanOverrideTheme(); // Set to false
        expect(themeProvider.fetchCanOverrideTheme(), false);
        final initialTheme = themeProvider.fetchTheme();
        themeProvider.toggleTheme();
        expect(themeProvider.fetchTheme(), initialTheme);
      });

      test(
        'notifyListeners is called when toggleTheme is invoked and can override is true',
        () {
          final themeProvider = ThemeProvider();
          expect(themeProvider.fetchCanOverrideTheme(), true);
          var listenerCalled = false;
          themeProvider.addListener(() {
            listenerCalled = true;
          });

          themeProvider.toggleTheme();
          expect(listenerCalled, true);
        },
      );

      test(
        'notifyListeners is not called when toggleTheme is invoked and can override is false',
        () {
          final themeProvider = ThemeProvider();
          themeProvider.toggleCanOverrideTheme(); // Set to false
          expect(themeProvider.fetchCanOverrideTheme(), false);
          var listenerCalled = false;
          themeProvider.addListener(() {
            listenerCalled = true;
          });

          themeProvider.toggleTheme();
          expect(listenerCalled, false);
        },
      );
    });

    group('toggleCanOverrideTheme', () {
      test('toggles can override theme from true to false', () {
        final themeProvider = ThemeProvider();
        expect(themeProvider.fetchCanOverrideTheme(), true);
        themeProvider.toggleCanOverrideTheme();
        expect(themeProvider.fetchCanOverrideTheme(), false);
      });

      test('toggles can override theme from false to true', () {
        final themeProvider = ThemeProvider();
        themeProvider.toggleCanOverrideTheme(); // Set to false
        expect(themeProvider.fetchCanOverrideTheme(), false);
        themeProvider.toggleCanOverrideTheme();
        expect(themeProvider.fetchCanOverrideTheme(), true);
      });

      test(
        'notifyListeners is called when toggleCanOverrideTheme is invoked',
        () {
          final themeProvider = ThemeProvider();
          var listenerCalled = false;
          themeProvider.addListener(() {
            listenerCalled = true;
          });

          themeProvider.toggleCanOverrideTheme();
          expect(listenerCalled, true);
        },
      );
    });
  });
}
