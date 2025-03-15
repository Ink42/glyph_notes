import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<Directory> _getOrCreateFolder(String folderName) async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final Directory newDir = Directory(path.join(appDocDir.path, folderName));
      
      if (!await newDir.exists()) {
        return await newDir.create(recursive: true);
      }
      return newDir;
    } catch (e) {
      debugPrint('Error creating folder: $e');
      rethrow;
    }
  }

  Future<File> createMarkdownFile(
      String folderName, String fileName, String content) async {
    try {
      if (fileName.isEmpty) {
        throw Exception('File name cannot be empty');
      }
      
      final Directory dir = await _getOrCreateFolder(folderName);
      final String safeFileName = _sanitizeFileName(fileName);
      final File file = File(path.join(dir.path, '$safeFileName.md'));
      
      return await file.writeAsString(content);
    } catch (e) {
      debugPrint('Error creating markdown file: $e');
      rethrow;
    }
  }

  Future<List<FileSystemEntity>> listFiles(String folderName) async {
    try {
      final Directory dir = await _getOrCreateFolder(folderName);
      return await dir.list().toList();
    } catch (e) {
      debugPrint('Error listing files: $e');
      return [];
    }
  }

  Future<File> appendToFile(
      String folderName, String fileName, String content) async {
    try {
      final Directory dir = await _getOrCreateFolder(folderName);
      final String safeFileName = _sanitizeFileName(fileName);
      final File file = File(path.join(dir.path, '$safeFileName.md'));
      
      if (await file.exists()) {
        return await file.writeAsString('\n$content', mode: FileMode.append);
      }
      return await file.writeAsString(content);
    } catch (e) {
      debugPrint('Error appending to file: $e');
      rethrow;
    }
  }

  String _sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  Future<bool> deleteFile(String folderName, String fileName) async {
    try {
      final Directory dir = await _getOrCreateFolder(folderName);
      final File file = File(path.join(dir.path, '$fileName.md'));
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error deleting file: $e');
      return false;
    }
  }
}