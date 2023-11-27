import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/bottom_menu_screens/uploadedPlaceList.dart';

class addLocation_user extends StatefulWidget {
  const addLocation_user({super.key});

  @override
  State<addLocation_user> createState() => _addLocation_userState();
}

class _addLocation_userState extends State<addLocation_user> {
  File? image;

  TextEditingController placeName = TextEditingController();
  TextEditingController placeDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      'Add Location',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.add_location_alt_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              image != null
                  ? Image.file(
                      image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.add_a_photo,
                      size: 150,
                      color: Color.fromARGB(255, 127, 126, 126),
                    ),
              Text(
                'Upload Image',
                style: TextStyle(
                  fontFamily: 'kanit',
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 70, 142, 210),
                  )),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  child: Text(
                    'camera',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 70, 142, 210),
                  )),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        hintText: 'Place, city.',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: placeName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        // fillColor: Colors.grey,
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: placeDescription,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter atleast 10 words";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 70, 142, 210),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final userProvider = Provider.of<UserProvider>(
                              context,
                              listen: false,
                            );
                            final username = userProvider.username;

                            if (username != null) {
                              final place = PlaceList(
                                placeName: placeName.text,
                                description: placeDescription.text,
                                imageUrl: image?.path ?? '',
                              );
                              final userBox = await Hive.openBox<User>('users');
                              final currentUser =
                                  userBox.get(username.username);
                              if (currentUser != null) {
                                if (currentUser.uploadedPlaces!.any(
                                    (p) => p.placeName == place.placeName)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Place is already exist',
                                      ),
                                    ),
                                  );
                                } else {
                                  currentUser.uploadedPlaces!.add(place);
                                  userBox.put(username.username, currentUser);
                                  Fluttertoast.showToast(
                                    msg: 'Place sent to admin for approval',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                  );
                                  placeName.clear();
                                  placeDescription.clear();
                                  setState(() {
                                    image = null;
                                  });
                                }
                              }
                            }
                          }
                        },
                        child: Text(
                          'upload',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 4,
              ),
              Text(
                'Status of requested places',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 70, 142, 210)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadedPlacesList(),
                    ),
                  );
                },
                child: Text(
                  'check the uploaded places',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  // final userProvider = Provider.of<UserProvider>(context, listen: false);
}
