
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class FileManager{


Future<List<FileSystemEntity>> listFiles(String folderName) async {
  final Directory dir = await createFolder(folderName);
  return dir.list().toList();
}



Future<File> appendToFile(String folderName, String fileName, String content) async {
  final Directory dir = await createFolder(folderName);
  final File file = File(path.join(dir.path, '$fileName.md'));
  
  if (await file.exists()) {
    return file.writeAsString(content, mode: FileMode.append);
  } else {
    return file.writeAsString(content);
  }
}


Future<Directory> createFolder(String folderName) async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  

  final Directory newDir = Directory(path.join(appDocDir.path, folderName));
  
 
  if (await newDir.exists() == false) {
    return newDir.create();
  }
  
  return newDir;
}


Future<File> createMarkdownFile(String folderName, String fileName, String content) async {
  final Directory dir = await createFolder(folderName);
  final File file = File(path.join(dir.path, '$fileName.md'));
  return file.writeAsString(content);
}
}
