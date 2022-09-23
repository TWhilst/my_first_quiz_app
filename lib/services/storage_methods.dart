import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    /// create the file to store the image on the firebaseStorage
    Reference ref = storage.ref().child(childName).child(id);

    /// add the data you want to store
    UploadTask uploadTask = ref.putData(file);

    /// the snapshot is what is returned
    TaskSnapshot snap = await uploadTask;

    /// then we convert it to string
    String image = await snap.ref.getDownloadURL();
    return image;
  }
}