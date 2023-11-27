import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/data/adminPages/detailed_requested_places.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class requestedPlaces extends StatefulWidget {
  final String username;

  requestedPlaces({required this.username});

  @override
  State<requestedPlaces> createState() => _requestedPlacesState();
}

class _requestedPlacesState extends State<requestedPlaces> {
  List<PlaceList> requestedPlaces =
      []; // You need to load user's requested places here
  PlaceStatus? selectedPlaceStatus;

  @override
  void initState() {
    super.initState();
    loadUploadedPlaces();
    // final thisPlace = Hive.box<PlaceList>('places').getAt(index)
  }

  Future<void> loadUploadedPlaces() async {
    final username = widget.username;
    final userBox = await Hive.openBox<User>('users');

    if (username != null && userBox.isOpen) {
      final currentUser = userBox.get(username);
      if (currentUser != null) {
        setState(() {
          requestedPlaces = currentUser.uploadedPlaces!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 2, 22),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 10, 2, 22),
        title: Text(
          'Requested Places by ${widget.username}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: requestedPlaces.isEmpty
          ? Center(
              child: Text(
                'No requested places for ${widget.username}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                shrinkWrap: true,
                itemCount: requestedPlaces.length,
                itemBuilder: (context, index) {
                  final place = requestedPlaces[index];
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                final specificPlace = PlaceList(
                                    placeName: place.placeName,
                                    description: place.placeName,
                                    imageUrl: place.imageUrl);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailedRequestPlace(
                                        place: specificPlace,
                                        description: place.description,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(place.imageUrl!),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Text(
                              place.placeName!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
