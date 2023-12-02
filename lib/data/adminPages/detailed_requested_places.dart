import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class DetailedRequestPlace extends StatefulWidget {
   DetailedRequestPlace({required this.place, required this.description});
  final PlaceList place;
  String? description;
  @override
  State<DetailedRequestPlace> createState() => _DetailedRequestPlaceState();
}

class _DetailedRequestPlaceState extends State<DetailedRequestPlace> {
  PlaceStatus? selectedPlaceStatus;

  @override
  void initState() {
    super.initState();
    Hive.openBox<PlaceList>('places').then((box) {
      final thisPlace = box.get(widget.place.placeName);
      setState(() {
        selectedPlaceStatus = thisPlace?.status;
      });
    });
    // final thisPlace = Hive.box<PlaceList>('places').get(widget.place.placeName);
    // selectedPlaceStatus = thisPlace?.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 2, 22),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: FileImage(
                                  File(widget.place.imageUrl!),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(widget.place.placeName!),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.description!)
                          ),
                        ),
                        Text(
                          'Update Place Status',
                        ),
                        SizedBox(
                          height: 300,
                          child: Column(
                            children: [
                              buildPlaceStatusPicker(
                                PlaceStatus.placeRejected,
                                'Ignore',
                                'Ignore for Now',
                                Icon(
                                  Icons.circle,
                                  color: Colors.orange,
                                ),
                                BorderRadius.circular(20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              buildPlaceStatusPicker(
                                  PlaceStatus.placeAccepted,
                                  'Accept',
                                  'Accept this place',
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                  ),
                                  BorderRadius.circular(20)),
                                  SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () async {
                                  final allPlace = Hive.box<PlaceList>('places');
                                  final currentPlace = widget.place;
        
                                  if (currentPlace != null) {
                                    if (selectedPlaceStatus ==
                                        PlaceStatus.placeAccepted) {
                                      final updatedPlace = PlaceList(
                                        placeName: currentPlace.placeName,
                                        description: widget.description,
                                        imageUrl: currentPlace.imageUrl,
                                        status: selectedPlaceStatus,
                                      );
                                      allPlace.put(
                                          updatedPlace.placeName, updatedPlace);
                                      print(
                                          'New place entry added: ${updatedPlace.status}');
                                          Fluttertoast.showToast(
                                            msg: 'Place is Accepted',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                          );
                                    } else if (selectedPlaceStatus ==
                                        PlaceStatus.placeRejected) {
                                      currentPlace.status = selectedPlaceStatus;
                                      allPlace.put(
                                          currentPlace.placeName, currentPlace);
                                      print(
                                          'place status updated to: ${currentPlace.status}');
                                          Fluttertoast.showToast(
                                          msg: 'Place is rejected for now',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                        );
                                    } else {
                                      print('Handling other status updates');
                                    }
                                  } else {
                                    print('Error: Place not found');
                                  }
                                },
                                child: Text('Update'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceStatusPicker(
    PlaceStatus value,
    String title,
    String subtitle,
    Icon icon,
    BorderRadiusGeometry? borderRadius,
  ) {
    final bool isOptionDisabled = selectedPlaceStatus != null && selectedPlaceStatus != value;
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ??
        BorderRadius.all(
          Radius.elliptical(20, 20),
        ),
      ),
      child: InkResponse(
        onTap: () {
          if (!isOptionDisabled) {
            setState(() {
              selectedPlaceStatus = value;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Opacity(
            opacity: isOptionDisabled ? 0.5 : 1.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<PlaceStatus>(
                      activeColor: Colors.blue,
                      value: value,
                      groupValue: selectedPlaceStatus,
                      onChanged: (PlaceStatus? selectedStatus) {
                        if (!isOptionDisabled) {
                          setState(() {
                            selectedPlaceStatus = selectedStatus;
                          });
                        }
                      },
                    ),
                    icon,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        if (subtitle.isNotEmpty) Text(subtitle),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
