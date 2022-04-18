import 'dart:io'; // for File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  late String product_name;
  late String product_desc;
  late String product_price;
  void updateLink(String uid, String downloadUrl) async {
    Map<String, dynamic> product_details = {
      "product_name": product_name,
      "product_desc": product_desc,
      "product_price": product_price,
      "product_image": downloadUrl
    };
    try {
      CollectionReference userdata =
          FirebaseFirestore.instance.collection('userdata');

      userdata.doc(uid).update({
        'myProducts': FieldValue.arrayUnion([product_details]),
      });
      print("uploaded ");
      Fluttertoast.showToast(
        msg: "Successfully Uploaded",
        toastLength: Toast.LENGTH_SHORT,
      );
      setState(() {
        product_name = "";
        product_desc = "";
        product_price = "";
      });
    } catch (e) {
      print(e);
    }
  }

  uploadImage() async {
    //Check Permissions
    Fluttertoast.showToast(
      msg: "Uploading...",
      toastLength: Toast.LENGTH_SHORT,
    );
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
          print('here ${uid}');
          await FirebaseFirestore.instance
              .collection('userdata')
              .doc(uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print("dff");
              print(documentSnapshot.data()!);
            } else {
              print('Document does not exist on the database');
            }
          });
          updateLink(uid!, downloadUrl);
          //print(downloadUrl);
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
          TextField(
            onChanged: (value) => product_name = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            onChanged: (value) => product_desc = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            onChanged: (value) => product_price = value,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Price',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: 'Item Name',
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              child: new Text('Import And Upload'),
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
