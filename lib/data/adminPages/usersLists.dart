import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class usersLists extends StatefulWidget {
  const usersLists({super.key});

  @override
  State<usersLists> createState() => _usersListsState();
}

class _usersListsState extends State<usersLists> {
  final userBox = Hive.box<User>('users');
  late Future<List<User>> usersFuture ;
  @override
  void initState() {
    super.initState();
    usersFuture = getAllUsers(userBox);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Users Overview',
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
        backgroundColor: Color.fromARGB(255, 10, 2, 22),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              child: Center(
                child: Icon(Icons.people,
                color: Colors.grey,
                size: 100,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 30),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                  )
                ]
                ),
                child: FutureBuilder<List<User>>(
                  future: usersFuture,
                  builder: (BuildContext conntext, AsyncSnapshot<List<User>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userList = snapshot.data;
              
                      if (userList!.isEmpty) {
                        return Center(child: Text('No users found.'));
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          thickness: 2,
                        ),
                        shrinkWrap: true,
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final user = userList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              child: Container(
                                child: user.profilePic == null 
                                ? Icon(Icons.person)
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(File(user.profilePic!),
                                  width: 80,
                                  fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ),
                            title: Text('Username : ${user.username}'),
                            subtitle: Text('Password : ${user.password}'),
                            trailing: InkWell(
                              onTap: () {
                                if(user.username != null){
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete user'),
                                      content: Text(
                                        'Do you want to delete ${user.username} from Database',
                                      ),
                                      actions: [
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: Text('Cancel')),
                                        TextButton(onPressed: ()async {
                                          await deleteUser(user.username!);
                                          setState(() {
                                            usersFuture = getAllUsers(userBox);
                                          });
                                          Navigator.pop(context);
                                        }, child: Text('Delete'))
                                      ],
                                    );
                                  },);
                                }
                              },
                              child: Icon(Icons.delete)),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}