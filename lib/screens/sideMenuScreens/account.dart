import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/screens/sideMenuScreens/edit_Profile.dart';

class accountPage extends StatefulWidget {
  accountPage({required this.username});
  final String username;

  @override
  State<accountPage> createState() => _accountPageState();
}

enum Reasons { notInterested, otherReason, needUpgrade }

class _accountPageState extends State<accountPage> {
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
      });
    } catch (error) {
      print('error on fetching user data');
    }
  }

  Reasons? _selectedReason = Reasons.needUpgrade;

    final String _content =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum diam ipsum, lobortis quis ultricies non, lacinia at justo.';

  void _shareContent() {
    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Profile',
        style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        elevation: 0,
      ),
      body: Container(
        color: Color.fromARGB(255, 35, 35, 35),
        width: double.infinity,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 70)),
            user?.profilePic != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File(user!.profilePic!),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : image == null
                    ? CircleAvatar(
                        radius: 90,
                        child: Icon(
                          Icons.person,
                          size: 150,
                          color: Colors.white,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
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
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Color.fromARGB(255, 70, 142, 210),
                minimumSize: Size(200, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfile(username: user!.username!),
                  ),
                );
              },
              child: Text(
                'Edit Profile',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ProfileSettings(
                    title: 'Delete Account',
                    icon: Icons.delete,
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Container(
                                height: 315,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Choose a reason for deleting account',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Divider(),
                                    RadioListTile(
                                      subtitle: Text(
                                        'Use of this application has ended',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      title: Text('Not Interested'),
                                      value: Reasons.notInterested,
                                      groupValue: _selectedReason,
                                      onChanged: (Reasons? value) {
                                        setState(() {
                                          _selectedReason = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      subtitle: Text(
                                        'The application need more features',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      title: Text('Need Upgrade'),
                                      value: Reasons.needUpgrade,
                                      groupValue: _selectedReason,
                                      onChanged: (Reasons? value) {
                                        setState(() {
                                          _selectedReason = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      subtitle: Text(
                                        'Due to other reasons',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      title: Text('Other Reason'),
                                      value: Reasons.otherReason,
                                      groupValue: _selectedReason,
                                      onChanged: (Reasons? value) {
                                        setState(() {
                                          _selectedReason = value!;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Close'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Future.delayed(Duration.zero, () {
                                              showDialog(
                                                context: context, builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        TextButton(onPressed: ()async{
                                                          Timer(Duration(seconds: 3), ()async {
                                                            deleteUser(user?.username ?? '');
                                                            SchedulerBinding.instance.addPostFrameCallback((_) {
                                                            signout(context);
                                                          });
                                                           });
                                                          showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              child: Container(
                                                                height: 220,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/images/logoOfTM.png',
                                                                      width: 150,
                                                                      height: 150,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: CircularProgressIndicator(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        }, child: Text('Delete Account permanently')),
                                                        TextButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child: Text('Cancel'))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              );
                                            },
                                              );
                                            },
                                            child: Text('Continue'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                  ProfileSettings(
                    title: 'Information',
                    icon: Icons.info,
                    onPress: () {
                    Navigator.pushNamed(context, '/aboutUs');
                    },
                  ),
                  ProfileSettings(
                    title: 'Share TravelMate',
                    icon: Icons.share,
                    onPress: () {
                      _shareContent();
                    },
                  ),
                  // ProfileSettings(
                  //   title: 'LogOut',
                  //   icon: Icons.logout,
                  //   onPress: () {},
                  //   textColor: Colors.red,
                  //   endIcon: false,
                  // )
                ],
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

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon(
          Icons.arrow_forward_ios_sharp,
          size: 18,
          color: Colors.grey,
        ),
      ),
      onTap: onPress,
    );
  }
}
