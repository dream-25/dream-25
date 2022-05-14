import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ServicerStorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String filePath, String fileName, String upPath) async {
    File file = File(filePath);

    await storage.ref("$upPath/$fileName").putFile(file);
  }

  Future<String> downloadURl(String path) async {
    String downloadURL = await storage.ref(path).getDownloadURL();
    return downloadURL;
  }
}
