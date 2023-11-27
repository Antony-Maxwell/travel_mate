import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_mate/db/functions/functions/add_more_function.dart';
class addMore extends StatefulWidget {
  const addMore({super.key});

  @override
  State<addMore> createState() => _addMoreState();
}

class _addMoreState extends State<addMore> {

  final Map<String, Function> categoryFunctions = {
  "PlaceList" : addMorePlace,
  "BestPlaces" : addBestPlaces,
  "MostVisited" : addMostVisited,
  "Favourite" : addFavouritePlaces,
  "NewAdded" : addNewAdded,
  "Famous" : addFamous,
  "Hidden" : addHidden,
};
  _addMoreState() {
    _SelectedVal = hiveList[0];
  }

  final hiveList = [
    "PlaceList",
    "BestPlaces",
    "MostVisited",
    "Favourite",
    "NewAdded",
    "Famous",
    "Hidden",
  ];
  String? _SelectedVal = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _placeName = TextEditingController();
  TextEditingController _description = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 2, 22),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 10, 2, 22),
        title: Text(
          'Add more Places',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                'Choose from',
                              ),
                              Divider(),
                              TextButton(
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                        ),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/images/nature.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ))),
                Text(
                  'Upload the image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          // fillColor: Colors.grey,
                          // filled: true,
                          hintText: 'Enter place name',
                          labelText: 'Place Name',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _placeName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Place name is must";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          // fillColor: Colors.grey,
                          // filled: true,
                          hintText: 'Enter description',
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _description,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please give a description";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        style: TextStyle(color: Colors.white),
                        value: _SelectedVal,
                        items: hiveList.map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                                key: Key(e), // Add a unique key for each DropdownMenuItem
                              ),
                            ).toList(),
                        onChanged: (val) {
                          setState(() {
                            _SelectedVal = val as String;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.grey,
                        ),
                        elevation: 0,
                        dropdownColor: Color.fromARGB(255, 10, 2, 22),
                        decoration: InputDecoration(
                          labelText: "Place Category",
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.explore,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            final place = _placeName.text;
                            final description = _description.text;
                            final imageUrl = image!.path;
                            if (_formKey.currentState!.validate()) {
                              final selectedFunction = categoryFunctions[_SelectedVal!];
                              if(selectedFunction != null){
                                selectedFunction(imageUrl, place, description, context);
                                print('successfully added place $place');
                              }else{
                                print('No Function found for category $_SelectedVal');
                              }
                              // addMorePlace(
                              //     imageUrl, place, description, context,);
                              // print('successfully added place ${place}');
                            }
                          },
                          child: Text('Upload'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
}
