import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/Services/notifi_service.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';

DateTime scheduleTime = DateTime.now();

class savedPage extends StatefulWidget {
  const savedPage({super.key});

  @override
  State<savedPage> createState() => _savedLocationState();
}

class _savedLocationState extends State<savedPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    String? username = userProvider.username?.username ?? "user";
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    'Saved Location',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 620,
              color: Colors.transparent,
              child: FutureBuilder<List<UsersavedLocation>>(
                future: fetchSavedLocations(username),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final savedLocations = snapshot.data;
                    if (savedLocations != null) {
                      return savedLocations.isEmpty
                          ? Center(
                              child: Text(
                                'No saved location found',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (ctx, index) {
                                final location = savedLocations[index];
                                return Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: location.imagePath
                                              .startsWith('assets/')
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                location.imagePath,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.file(
                                                File(
                                                  location.imagePath,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                    Text(
                                      location.placeName ?? '',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Remove'),
                                                  content: Text(
                                                      'Do you really want to remove the place from favourite'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        if (await removeFromSave(
                                                            username,
                                                            location.placeName!,
                                                            location
                                                                .imagePath)) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                '${location.placeName} is successfully removed',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            backgroundColor:
                                                                Colors.grey,
                                                            textColor:
                                                                Colors.white,
                                                          );
                                                          setState(() {
                                                            savedLocations
                                                                .remove(
                                                                    location);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child: Text('Remove'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text('Remove'),
                                        ),
                                        Row(
                                          children: [
                                            DatePickerTxt(),
                                            ScheduleBtn(),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: savedLocations.length,
                            );
                    } else {
                      // Handle the case where there are no saved locations.
                      return Center(
                        child: Text('No saved locations found.'),
                      );
                    }
                  } else {
                    // Handle loading state.
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<UsersavedLocation>> fetchSavedLocations(String username) async {
    final savedLocationsBox = await Hive.openBox<User>('users');
    final user = savedLocationsBox.get(username);

    if (user != null) {
      return user.savedLocation ?? [];
    } else {
      return [];
    }
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        NotificationService().scheduleNotification(
        title: 'Hey. Have you forgot your trip..',
        body: 'Get Ready For Your Trip',
        scheduleNotificationDateTime: scheduleTime);
        print('notification set for $scheduleTime');
        Fluttertoast.showToast(
          msg: 'We Will Notify Your Trip',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
      },
      child: Text('Set'),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          dp.DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              onChanged: (date) => scheduleTime = date,
              onConfirm: (date) {});
        },
        child: Text('Pick Date Time',
        style: TextStyle(
          color: Colors.grey,
        ),));
  }
}
