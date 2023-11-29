import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/bottom_menu_screens/detailed_uploaded_place.dart';

class UploadedPlacesList extends StatefulWidget {
  @override
  _UploadedPlacesListState createState() => _UploadedPlacesListState();
}

class _UploadedPlacesListState extends State<UploadedPlacesList> {
  List<PlaceList> uploadedPlaces = [];
  PlaceList? thisPlace;

  @override
  void initState() {
    super.initState();
    loadUploadedPlaces();
  }

  Future<void> loadUploadedPlaces() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final username = userProvider.username;
    final userBox = await Hive.openBox<User>('users');

    // Ensure the user is not null and the box is open
    if (username != null && userBox.isOpen) {
      final currentUser = userBox.get(username.username);
      if (currentUser != null) {
        setState(() {
          uploadedPlaces = currentUser.uploadedPlaces!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Uploaded Places',
                    style: TextStyle(
                    fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 700,
              color: Colors.transparent,
              child: uploadedPlaces.isEmpty
            ? Center(
                child: Text('No uploaded places found.',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: uploadedPlaces.length,
                itemBuilder: (context, index) {
                  PlaceList place = uploadedPlaces[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            final specificPlace = PlaceList(placeName: place.placeName, description: place.description, imageUrl: place.imageUrl);
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DetailedUploadedPlace(place: specificPlace,);
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            width: double.infinity,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(place.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          place.placeName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
