import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<Directory> createFolder(String folderName) async {

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  
  final Directory newDir = Directory(path.join(appDocDir.path, folderName));
  
  if (await newDir.exists() == false) {
    return newDir.create();
  }
  
  return newDir;
}



Future<File> createTextFile(String folderName, String fileName, String content) async {

  final Directory dir = await createFolder(folderName);
  
  final File file = File(path.join(dir.path, '$fileName.txt'));
  
  return file.writeAsString(content);
}



// Folder
// File - edit
// loads checks if contaner exisit if it does 
////

