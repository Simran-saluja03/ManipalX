import 'dart:io'; // for File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donations extends StatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  late File _image;
  get picker => ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  late PickedFile image;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void updateLink(String uid, String downloadUrl) async {
    try {
      CollectionReference userdata =
          FirebaseFirestore.instance.collection('userdata');

      userdata.doc(uid).update({
        'myDonations': FieldValue.arrayUnion([downloadUrl]),
      });
    } catch (e) {
      print(e);
    }
  }

  uploadImage() async {
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        try {
          String fileName = file.path.split('/').last;
          var snapshot = await _firebaseStorage
              .ref()
              .child('donations/' + fileName)
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          final User? user = await auth.currentUser;
          final uid = user?.uid;
          updateLink(uid!, downloadUrl);
          print(downloadUrl);
        } catch (e) {
          print(e);
        }
        // setState(() {
        //   imageUrl = downloadUrl;
        // });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   //File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contact Number',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Item Name',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              child: new Text('Select Image from Gallery'),
              onPressed: () {
                uploadImage();
              }),
          // SizedBox(
          //   height: 200.0,
          //   width: 300.0,
          //   child: image == Null
          //       ? Center(child: new Text('Sorry nothing selected!!'))
          //       : Center(child: new Image.file(_image)),
          // )
        ],
      ),
    );
  }
}
