import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/data/adminPages/requestedPlaces.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';

class requests extends StatefulWidget {
  const requests({super.key});

  @override
  State<requests> createState() => _requestsState();
}

class _requestsState extends State<requests> {
  List<PlaceList> uploadedPlaces = [];

  @override
  void initState() {
    super.initState();
    // loadUploadedPlaces();
  }



  @override
  Widget build(BuildContext context) {
      final userBox = Hive.box<User>('users');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 10, 2, 22),
        title: Text(
          'User Uploaded Places',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1000,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 2, 5, 18),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                height: 700,
                width: double.infinity,
                child: FutureBuilder<List<User>>(
                  future: getAllUsers(userBox),
                  builder: (BuildContext conntext, AsyncSnapshot<List<User>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userList = snapshot.data;
              
                      if (userList!.isEmpty) {
                        return Text('No users found.');
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
                            title: Text('User : ${user.username}'),
                            onTap: () {
                              navigateToRequestedList(context, user.username!);
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void navigateToRequestedList(BuildContext context, String username) {
  // You can use Navigator to navigate to a new screen and pass values
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => requestedPlaces(username: username),
    ),
  );
}

}
