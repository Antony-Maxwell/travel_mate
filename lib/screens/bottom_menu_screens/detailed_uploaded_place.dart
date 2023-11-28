import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class DetailedUploadedPlace extends StatefulWidget {
  const DetailedUploadedPlace({required this.place});
  final PlaceList place;

  @override
  State<DetailedUploadedPlace> createState() => _DetailedUploadedPlaceState();
}

class _DetailedUploadedPlaceState extends State<DetailedUploadedPlace> {
  late String _sliderValue;
  PlaceList? thisPlace;
  @override
  void initState() {
    super.initState();
    thisPlace = Hive.box<PlaceList>('places').get(widget.place.placeName);
    _sliderValue = getStatusValue(thisPlace?.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detailed view',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey
                ),
                image: DecorationImage(
                  image: FileImage(
                    File(widget.place.imageUrl!),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.place.placeName!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 30,),
            Text(
              'Description :',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.place.description!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Text(
              'status :',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(
                  30
                )
              ),
              child: Text(
                _sliderValue,
                style: TextStyle(
                  color: getStatusColor(_sliderValue)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getStatusValue(PlaceStatus? status){
  switch (status){
    case PlaceStatus.placeAccepted:
    return 'ACCEPTED';
    case PlaceStatus.placeRejected:
    return 'REJECTED';
    default : 
    return 'PENDING';
  }
}
Color getStatusColor(String status) {
  switch (status) {
    case 'ACCEPTED':
      return Colors.green;
    case 'REJECTED':
      return Colors.red;
    default:
      return Colors.orange;
  }
}
