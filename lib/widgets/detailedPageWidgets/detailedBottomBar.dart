// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/db/functions/functions/comment_function.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/bottom_menu_screens/googleMap.dart';
import 'package:travel_mate/widgets/homePageWidgets/homeBottomBar.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';

class detailedBottomBar extends StatefulWidget {
  final String? placeName;
  final String imageAssetPath;
  final String? description;
  double? ratingTotal;
  detailedBottomBar({
    Key? key,
    required this.imageAssetPath,
    required this.placeName,
    required this.description,
    required this.ratingTotal,
  }) : super(key: key);

  @override
  State<detailedBottomBar> createState() => _detailedBottomBarState();
}

class _detailedBottomBarState extends State<detailedBottomBar> {
  TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
    );
    final username = userProvider.username!.username;
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      height: 700,
      decoration: BoxDecoration(
        color: Color(0xFFEDF2F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              top: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.placeName ?? '',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          widget.ratingTotal == null
                          ? '0'
                          :'${widget.ratingTotal}',
                          style: GoogleFonts.workSans(),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  widget.description ?? '',
                  style: GoogleFonts.poppins(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: FullScreenWidget(
                        disposeLevel: DisposeLevel.High,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: widget.imageAssetPath.startsWith('assets/')
                                ? Image.asset(
                                    widget.imageAssetPath,
                                    // fit: BoxFit.cover,
                                    width: 120,
                                    height: 90,
                                  )
                                : Image.file(File(widget.imageAssetPath),
                                    // fit: BoxFit.cover,
                                    width: 120,
                                    height: 90),),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await _saveLocation();
                          Fluttertoast.showToast(
                            msg: 'Place saved successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.bookmark_outline,
                            size: 30,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => location_googleMap(
                                        placeName: widget.placeName!,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[400],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Text(
                            'Get Direction',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 189, 203, 215),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: TextField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'Comment here',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  final place = widget.placeName;
                                  final comment = _commentController.text;
                                  addCommentToPlace(
                                      place!,
                                      username!,
                                      comment,
                                      widget.description!,
                                      widget.imageAssetPath);
                                  setState(() {
                                    _commentController.text = '';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                  ),
                                  child: Icon(
                                    Icons.send,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        child: FutureBuilder<List<Comments>>(
                          future: getComments(widget.placeName!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<Comments> comments = snapshot.data ?? [];

                              return ListView.separated(
                                itemCount: comments.length,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemBuilder: (context, index) {
                                  Comments comment = comments[index];
                                  String timeAgoString = timeago
                                      .format(comment.timestamp!, locale: 'en');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text(comment.userName ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                        ),
                                        subtitle:
                                            Text(comment.commentText ?? '',
                                            style: GoogleFonts.poppins(),
                                            ),
                                        trailing: Text('$timeAgoString'),
                                        // You can customize the appearance of each comment as needed
                                      ),
                                    ),
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
              ],
            ),
          )
        ],
      ),
    );
  }

// Define a separate async method to perform the asynchronous operations
  Future<bool> _saveLocation() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.username != null) {
      final username = userProvider.username!.username;

      final savedLocationsBox = await Hive.openBox<User>('users');
      final user = savedLocationsBox.get(username);
      print('$username saved ${widget.imageAssetPath}');
      print('${user?.username}');

      if (user != null) {
        if (user.savedLocation!
            .any((place) => place.placeName == widget.placeName)) {
          Fluttertoast.showToast(
            msg: 'Place is already saved',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        } else {
          final savedPath = UsersavedLocation(
            imagePath: widget.imageAssetPath,
            placeName: widget.placeName,
          );

          user.savedLocation!.add(savedPath);

          savedLocationsBox.put(username, user);

          // Add any additional logic you need after saving the location
        }
      }
    }
    return true;
  }
}
