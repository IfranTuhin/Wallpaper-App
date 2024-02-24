import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:wallpaper_app/screen/home_screen/home_screen.dart';
import 'package:wallpaper_app/service/database.dart';
import 'package:wallpaper_app/widgets/bottom_nav.dart';
class AdminWallpaper extends StatefulWidget {
  const AdminWallpaper({super.key});

  @override
  State<AdminWallpaper> createState() => _AdminWallpaperState();
}

class _AdminWallpaperState extends State<AdminWallpaper> {
  final List<String> categoryItems = ['Wild Life', 'Food', 'Nature', 'City'];
  String? value;
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;
  bool isLoading = false;

  Future getImage () async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    setState(() {

    });
  }

  uploadWallpaper() async {
    setState(() {
      isLoading = true;
    });
    if(selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('blogImages').child(addId);

      final UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        'Image' : downloadUrl,
        'Id' : addId,
      };
      await DatabaseMethods().addWallpaper(addItem, addId, value!).then((value) {
        Fluttertoast.showToast(
            msg: "Wallpaper has been Uploaded Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
   setState(() {
     isLoading = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavBar(),));
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black54),
        ),
        title: const Text(
          'Add Wallpaper',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            selectedImage == null ? GestureDetector(
              onTap: () {
                getImage();
              },
              child: Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 250,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ) : Center(
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: categoryItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )).toList(),
                  onChanged: (value) => setState(() {
                    this.value = value;
                  }),
                  hint: const Text('Select Category'),
                  value:  value,
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => uploadWallpaper(),
              child: isLoading ? const Center(child: CircularProgressIndicator(),) : Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Add Wallpaper",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
