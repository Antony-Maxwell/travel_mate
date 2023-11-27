
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users {
  String? username;
  List<LocationUser> location;
  List<UploadedLocation> uploadedLocations;
  List<PlannedTrips> plannedTrips = [];


  Users({
    required this.username,
    this.location = const [],
    this.uploadedLocations = const [],
    this.plannedTrips = const [],
  });
}

class PlannedTrips{
  String plannedplaceName;
  String plannedMembersTrip;
  String plannedAmountTrip;
  String plannedDateTrip;
  String plannedThingsTrip;
  String plannedImagesTrip;
  
  PlannedTrips({
    required this.plannedplaceName,
    required this.plannedMembersTrip,
    required this.plannedAmountTrip,
    required this.plannedDateTrip,
    required this.plannedThingsTrip,
    required this.plannedImagesTrip
  });
}

class UploadedLocation{
  String locationName;
  String locationDescription;
  String locationImage;

  UploadedLocation({
    required this.locationName,
    required this.locationDescription,
    required this.locationImage
  });
}

class LocationUser{
  String placeName;
  String description;

  LocationUser({required this.placeName, required this.description});
}

class UserProvider with ChangeNotifier {
  Users? _user;
  Users? get username => _user;

  void setUser(Users? username) {
    SharedPreferences.getInstance().then((prefs){
      prefs.setString('username', username!.username ?? 'none');
    });
    _user = username;
    notifyListeners();
  }
  void addLocation(LocationUser location){
    if(_user != null){
      _user!.location.add(location);
      notifyListeners();
    }
    
  }
  void updatePlannedTrips(PlannedTrips plannedTripsOfTrip){
    if(_user != null){
      _user!.plannedTrips.add(plannedTripsOfTrip);
      notifyListeners();
    }
  }
}

class PlaceData {
  final String placeName;
  final String description;
  final String imageUrl;

  PlaceData({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

class TripStateNotifier extends ChangeNotifier{
  bool _shouldRefresh = false;
  bool get shouldRefresh => _shouldRefresh;

  void setShouldRefresh(bool value){
    _shouldRefresh = value;
    notifyListeners();
  }
}

