import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/widgets/detailedPageWidgets/detailedBottomBar.dart';

class DetailedPage extends StatelessWidget {
  final String? imageAssetPath;
  final String? placeName;
  final String? description;
  final double? ratingTotal;
  
   DetailedPage({
    Key? key,
    required this.imageAssetPath,
    required this.placeName,
    required this.description,
    required this.ratingTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    if (imageAssetPath!.startsWith('assets/')) {
      decorationImage = DecorationImage(
        image: AssetImage(imageAssetPath!),
        fit: BoxFit.cover,
      );
    } else {
      decorationImage = DecorationImage(
        image: FileImage(
          File(imageAssetPath!),
        ),
        fit: BoxFit.cover,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: decorationImage,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.10,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF2F6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(height: 20),
                    // Other content before detailedBottomBar
                    detailedBottomBar(
                      ratingTotal: ratingTotal,
                      imageAssetPath: imageAssetPath!,
                      placeName: placeName,
                      description: description,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.arrow_back,
              color: Colors.white,
              size: 30,
              ),
              onPressed: () {
                Navigator.pop(context); // Navigate back when the back button is pressed
              },
            ),
          ),
        ],
      ),
    );
  }
}
