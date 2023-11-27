import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/widgets/detailedPageWidgets/detailedPage.dart';

class MountainScreens extends StatefulWidget {
  const MountainScreens({super.key});

  @override
  State<MountainScreens> createState() => _MountainScreensState();
}

class _MountainScreensState extends State<MountainScreens> {
  List<Hidden> mountainPlaces = [];
  void initState(){
    super.initState();
    fetchMountains().then((data){
      setState(() {
        mountainPlaces = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 70,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,),
                  ),
                  SizedBox(width: 70,),
                  Text(
                    'Mountains',
                    style: TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 700,
              color: Colors.transparent,
              child: mountainPlaces.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final location = mountainPlaces[index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: double.infinity,
                                  height: 230,
                                  child: location.imageUrl!.startsWith('assets/')
                                  ?
                                  Image.asset(
                                    location.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                  )
                                  : 
                                  Image.file(File(location.imageUrl!),
                                  fit: BoxFit.cover,
                                  )
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  location.placeName ?? '',
                                  style: TextStyle(
                                    fontFamily: 'kanit',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedPage(
                                          ratingTotal: 0,
                                          imageAssetPath: location.imageUrl,
                                          placeName: location.placeName,
                                          description: location.description,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: mountainPlaces.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}