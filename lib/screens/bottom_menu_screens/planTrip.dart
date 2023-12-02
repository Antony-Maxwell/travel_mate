import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/bottom_menu_screens/detailed_planned_trips.dart';

class userDetails extends StatefulWidget {
  const userDetails({super.key});

  @override
  State<userDetails> createState() => _userDetailsState();
}

class _userDetailsState extends State<userDetails> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<void> refresh() async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
      });
    }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      final tripState = Provider.of<TripStateNotifier>(context, listen: false);
      if(tripState.shouldRefresh){
        refresh();
        tripState.setShouldRefresh(false);
      }
    });
  }
    
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final username = userProvider.username?.username ?? 'user';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Plan your future destination',
                        style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.add_road_outlined,
                        color: Color.fromARGB(255, 255, 0, 0),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 585,
                color: Color.fromRGBO(35, 35, 35, 1),
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: refresh,
                  child: FutureBuilder<List<UserPlannedTrips>>(
                    future: getPlannedTrips(username),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final plannedTrips = snapshot.data;
                        if (plannedTrips != null) {
                          return plannedTrips.isEmpty
                        ? Center(
                            child: Text(
                              'No trips you have planned yet..!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (ctx, index) {
                              final location = plannedTrips[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DetailedPlannedTrips(
                                              amount: location.plannedAmount!,
                                              date: location.plannedDate!,
                                              imagePath: location.plannedImages,
                                              members: location.plannedMembers,
                                              placeName: location.plannedPlace,
                                              things: location.plannedThings,
                                              userName: username,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        child: Image.file(
                                          File(
                                            location.plannedImages!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        location.plannedPlace!,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: plannedTrips.length,
                          );
                        } else {
                          return Center(
                            child: Text(
                                'No trips you have planned yet, Go and plan some',),
                          );
                        }
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createTrips');
                    },
                    icon: Icon(
                      Icons.edit_calendar_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
