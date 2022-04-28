import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<firebase_storage.UploadTask?> uploadImage(
      String destination, File file) async {
    try {
      String ref = 'images/img-$destination.jpg';
      return storage.ref(ref).putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      debugPrint("Error Image Upload : ${e.message}");
      return null;
    }
  }

  Future<List<String>> uploadFileAndReturnListOfUrl(
      List<PickedFile> fileList) async {
    final imageUrlList = <String>[];
    for (final file in fileList) {
      firebase_storage.Reference ref;
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${path.basename(file.path)}');

      await ref.putFile(File(file.path)).whenComplete(() async {
        await ref.getDownloadURL().then(imageUrlList.add);
      });
    }
    return imageUrlList;
  }
}
