// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/categoryScreens/bestPlaces.dart';
import 'package:travel_mate/categoryScreens/famous.dart';
import 'package:travel_mate/categoryScreens/mountains.dart';
import 'package:travel_mate/categoryScreens/hidden.dart';
import 'package:travel_mate/categoryScreens/mostVisited.dart';
import 'package:travel_mate/categoryScreens/newAdded.dart';
import 'package:travel_mate/widgets/detailedPageWidgets/detailedPage.dart';
import 'package:travel_mate/widgets/homePageWidgets/homeAppBar.dart';
import 'package:travel_mate/widgets/homePageWidgets/homeBottomBar.dart';
import 'package:travel_mate/widgets/placeList.dart';
import 'package:share_plus/share_plus.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class userMain extends StatefulWidget {
  userMain({super.key});

  @override
  State<userMain> createState() => _userMainState();
}

class _userMainState extends State<userMain> {
  late Box<PlaceList> placeBox;

  @override
  void initState() {
    super.initState();
    openHiveBoxes();
  }
  Future<Box<PlaceList>> openHiveBoxes() async {
    placeBox = await Hive.openBox<PlaceList>('places');
    var nonRejectedPlaces = placeBox.values
        .where((place) => place.status != PlaceStatus.placeRejected)
        .toList();
    await placeBox.clear();
    for (var place in nonRejectedPlaces) {
      placeBox.put(place.placeName, place);
    }
    return placeBox;
  }

  Future<Box<Hidden>> fetchMountainsForHome() async {
    final mountainsBox = await Hive.openBox<Hidden>('hidden');
    return mountainsBox;
  }

  final category = [
    'Best Places',
    'Most Visited',
    'Mountains',
    'New Added',
    'Famous',
    'Hidden',
  ];

  final categoryItems = [
    BestPlacesScreen(),
    MostvisitedScreen(),
    MountainScreens(),
    NewAddedScreen(),
    FamousScreen(),
    ViewPlaceList(),
  ];
  SampleItem? selectedMenu;
  final menus = [
    'Save',
    'Share',
  ];

  final String _content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum diam ipsum, lobortis quis ultricies non, lacinia at justo.';

  void _shareContent() {
    Share.share(_content);
  }

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: homeAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: FutureBuilder<Box<Hidden>>(
                            future: fetchMountainsForHome(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final placeBox = snapshot.data;
                                final places = placeBox!.values.toList();

                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 10,
                                  ),
                                  itemCount: places.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final place = places[index];
                                    print('${place.placeName}');
                                    DecorationImage? decorationImage;
                                    if (place.imageUrl!.startsWith('assets/')) {
                                      decorationImage = DecorationImage(
                                        image: AssetImage(place.imageUrl ?? ''),
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      decorationImage = DecorationImage(
                                        image: FileImage(
                                          File(place.imageUrl ?? ''),
                                        ),
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailedPage(
                                              ratingTotal: 0,
                                              placeName: place.placeName,
                                              imageAssetPath: place.imageUrl,
                                              description: place.description,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 190,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 94, 93, 93),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          // width: 160,
                                          padding: EdgeInsets.all(20),
                                          // margin: EdgeInsets.only(left: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: decorationImage,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .bookmark_border_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  '${place.placeName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        for (int i = 0; i < 6; i++)
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 70, 142, 210),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                category[i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return categoryItems[i];
                                  },
                                ),
                              );
                            },
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder<Box<PlaceList>>(
                  future: openHiveBoxes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final placeBox = snapshot.data;
                      final places = placeBox!.values.toList();
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: places.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final place = places[index];
                          print('${place.placeName}');
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedPage(
                                          ratingTotal: place.rating,
                                          imageAssetPath: place.imageUrl,
                                          placeName: place.placeName,
                                          description: place.description,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 101, 101, 101)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: 200,
                                      width: 400,
                                      child:
                                          place.imageUrl!.startsWith('assets/')
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.asset(
                                                    place.imageUrl!,
                                                    fit: BoxFit.cover,
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.file(
                                                    File(place.imageUrl!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        place.placeName ?? '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      PopupMenuButton(
                                        iconColor: Colors.white,
                                        color: Colors.white,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem<int>(
                                              value: 0,
                                              child: Text("Share"),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Text("Rate"),
                                            ),
                                          ];
                                        },
                                        onSelected: (value) {
                                          if (value == 0) {
                                            _shareContent();
                                          } else if (value == 1) {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: 250,
                                                  child: AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          place.rating = rating;
                                                          await placeBox.put(
                                                              place.placeName,
                                                              place);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Submit'),
                                                      )
                                                    ],
                                                    title:
                                                        Text('Rate your place'),
                                                    content: RatingBar.builder(
                                                      minRating: 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                        );
                                                      },
                                                      onRatingUpdate: (rating) {
                                                        return setState(() {
                                                          this.rating = rating;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      '${place.rating ?? 0}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
