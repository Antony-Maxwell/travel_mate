import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/sideMenuScreens/account.dart';
import 'package:travel_mate/screens/sideMenuScreens/helpLine.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final menu = [
    'Home',
    'Account',
    'About Us',
    'Log Out',
  ];

  final icon = [
    Icon(Icons.home_outlined),
    Icon(Icons.person_outline_outlined),
    Icon(Icons.info_outline_rounded),
    Icon(Icons.logout_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final username = userProvider.username?.username ?? "default user";
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 5, 25, 41),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              width: 288,
              height: double.infinity,
              child: Column(
                children: [
                  InfoCard(name: '$username', role: 'Tourist'),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'BROWSE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        color: Colors.white24,
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                Navigator.pop(context);
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          accountPage(username: username),
                                    ));
                              } else if (index == 2) {
                                Navigator.pushNamed(context, '/aboutUs');
                              } else if (index == 3) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Log Out'),
                                      content: SingleChildScrollView(
                                        child: ListBody(children: [
                                          Text(
                                              'Do you really want to log out ?'),
                                        ]),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            signout(context);
                                          },
                                          child: Text('Log Out'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                print('object');
                              }
                            },
                            child: ListTile(
                              leading: icon[index],
                              iconColor: Colors.white,
                              title: Text(
                                menu[index],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // onTap: () {
                              //   print('object');
                              // },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.white24,
                            endIndent: 20,
                            indent: 20,
                          );
                        },
                        itemCount: menu.length,
                      ),
                      Divider(
                        color: Colors.white24,
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_sharp, size: 40),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 5, 25, 41),
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatefulWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.role,
  }) : super(key: key);

  final String name, role;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  User? user;
  void _fetchUserData() async {
    try {
      final fetchedUser = await getUserInfo(widget.name);
      setState(() {
        user = fetchedUser;
      });
    } catch (error) {
      print('error on fetching user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 200,
              width: 200,
              child: user?.profilePic != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        File(user!.profilePic!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircleAvatar(
                      radius: 90,
                      child: Icon(
                        Icons.person,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            user?.username ?? '',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
