import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({required this.username});
  final String username;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  User? user;
  File? image;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final fetchedUser = await getUserInfo(widget.username);
      setState(() {
        user = fetchedUser;
        _usernameController.text = user?.username ?? '';
        _passwordController.text = user?.password ?? '';
        _emailController.text = user?.email ?? '';
        _mobileController.text = user?.mobileNum ?? '';
      });
    } catch (error) {
      print('error on fetching user data');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 70)),
            user?.profilePic != null
                ? InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        File(user!.profilePic!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 190,
                            color: Colors.grey,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  'Choose From',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Divider(),
                                TextButton(
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      this.image = null;
                                    });
                                  },
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                : image == null
                    ? InkWell(
                        child: CircleAvatar(
                          radius: 90,
                          child: Icon(
                            Icons.person,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 190,
                                color: Colors.grey,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Choose From',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Divider(),
                                    TextButton(
                                      child: Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        pickImage(ImageSource.camera);
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      child: Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          this.image = null;
                                        });
                                      },
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            image!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 190,
                                color: Colors.grey,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Choose From',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Divider(),
                                    TextButton(
                                      child: Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        pickImage(ImageSource.camera);
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      child: Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          this.image = null;
                                        });
                                      },
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
            Text(
              widget.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            if (user != null && user!.email!.isNotEmpty)
              Text(
                user!.email ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Update your new details',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 205, 205),
                      ),
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 205, 205),
                      ),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 205, 205),
                      ),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 205, 205),
                      ),
                      decoration: InputDecoration(
                        labelText: "Mobile",
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color.fromARGB(255, 70, 142, 210),
                        minimumSize: Size(200, 40),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return 
                            AlertDialog(
                              title: Text('Update Profile'),
                              content: Text(
                                  'Do you really want to update the details'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                TextButton(
                                  onPressed: () async {
                                    if (widget.username != null) {
                                      final userBox =
                                          await Hive.openBox<User>('users');
                                      final updatedUser = User(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        email: _emailController.text,
                                        mobileNum: _mobileController.text,
                                        profilePic: (image != null)
                                            ? image!.path
                                            : user!.profilePic,
                                      );

                                      userBox.put(widget.username, updatedUser);
                                      print('updated ${widget.username}');
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                      msg: 'Details upated successfully',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                    );
                                    } else {
                                      print('unable to update user details');
                                    }
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Update',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
