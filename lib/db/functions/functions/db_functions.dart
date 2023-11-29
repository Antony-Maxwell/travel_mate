import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/widgets/adminWidgets/adminMain.dart';
import 'package:travel_mate/authenthication/login.dart';
import 'package:travel_mate/authenthication/splashScreen.dart';

Future<List<User>> getAllUsers(Box<User> users) async {
  return users.values.toList();
}


Future<List<UserPlannedTrips>> getallplannedTrips(
    Box<UserPlannedTrips> plannedTrips) async {
  return plannedTrips.values.toList();
}

ValueNotifier<List<UsersavedLocation>> savedListNotifier = ValueNotifier([]);
ValueNotifier<List<UserPlannedTrips>> plannedTripNotifier = ValueNotifier([]);

//sign up function
Future<bool> saveToHive(String username, String password, String email) async {
  print('function called');
  if (username.length > 4 && password.length > 4) {
    try {
      final userBox = await Hive.openBox<User>('users');
      if (!userBox.containsKey(username)) {
        final savedLocations = <UsersavedLocation>[];
        final user = User(
          username: username,
          password: password,
          savedLocation: savedLocations,
          email: email,
        );
        await userBox.put(username, user);
        await userBox.close();
        return true;
      } else {
        await userBox.close();
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false; // Handle any errors
    }
  } else {
    print('Invalid data');
    return false;
  }
}

//login function
Future<bool> loginUser(BuildContext ctx, String userEnteredUsername,
    String userEnteredPassword) async {
  final adminName = "admin";
  final adminPass = "admin";

  final storedUserCredentials = await getUserCredentials(userEnteredUsername);

  if (storedUserCredentials != null &&
      userEnteredUsername == storedUserCredentials.username &&
      userEnteredPassword == storedUserCredentials.password) {
    print(
        "Navigating to '/bottomMenu' with username: ${storedUserCredentials.username}");

    final username = storedUserCredentials.username;
    final user = Users(username: username);
    Provider.of<UserProvider>(ctx, listen: false).setUser(user);
    Navigator.pushNamedAndRemoveUntil(
      ctx,
      '/bottomMenu',
      (route) => false,
      arguments: username,
    );

    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(splashScreenState.KEYLOGIN, true);
    return true;
  } else if (userEnteredUsername == adminName &&
      userEnteredPassword == adminPass) {
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(splashScreenState.ISADMINLOGGED, false);
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => adminMain(),
      ),
    );
    return true;
  } else {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text('Invalid username or password'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    return false;
  }
}

//getting user credentials from hive

Future<User?> getUserCredentials(username) async {
  final userBox = await Hive.openBox<User>('users');
  if (userBox.isNotEmpty) {
    final userCredentials = userBox.get(username);
    return userCredentials;
  }
  return null;
}

//create trip function

Future<void>addTrip()async{

}

Future<void> getfavPlace() async {
  final favPlaceDB = await Hive.openBox<UsersavedLocation>('saved_places');
  savedListNotifier.value.clear();
  savedListNotifier.value.addAll(favPlaceDB.values);
}

Future<List<BestPlaces>> fetchBestPlaces() async {
  final bestplacesBox = await Hive.openBox<BestPlaces>('bestPlace');
  List<BestPlaces> allPlaces = bestplacesBox.values.cast<BestPlaces>().toList();
  return allPlaces;
}

Future<List<Famous>> fetchFamousPlaces() async {
  final famousBox = await Hive.openBox<Famous>('famous');
  List<Famous> allPlaces = famousBox.values.cast<Famous>().toList();
  return allPlaces;
}

Future<List<MostVisited>> fetchMostVisited() async {
  final mostVisitedBox = await Hive.openBox<MostVisited>('mostVisited');
  List<MostVisited> allPlaces =
      mostVisitedBox.values.cast<MostVisited>().toList();
  return allPlaces;
}

Future<List<Hidden>> fetchMountains() async {
  final mountainsBox = await Hive.openBox<Hidden>('hidden');
  List<Hidden> allPlaces = mountainsBox.values.cast<Hidden>().toList();
  return allPlaces;
}

Future<List<NewAdded>> fetchNewAdded() async {
  final newAddedBox = await Hive.openBox<NewAdded>('newAdded');
  List<NewAdded> allPlaces = newAddedBox.values.cast<NewAdded>().toList();
  return allPlaces;
}

Future<List<PlaceList>> getAllUploadedPlaces() async {
  final userBox = await Hive.box<User>('users');
  List<PlaceList> allUploadedPlaces = [];

  for (int i = 0; i < userBox.length; i++) {
    final user = userBox.get(i);
    if (user != null && user.uploadedPlaces != null) {
      allUploadedPlaces.addAll(user.uploadedPlaces!);
      print(user.uploadedPlaces!.last);
    }
  }
  return allUploadedPlaces;
}

Future<Box<PlaceList>> gellAllplace() async {
  final wholeplaceBox = await Hive.openBox<PlaceList>('places');
  return wholeplaceBox;
}

Future<List<UserPlannedTrips>> getPlannedTrips(String username) async {
  final plannedTripBox = await Hive.openBox<User>('users');
  final user = plannedTripBox.get(username);

  if (user != null) {
    return user.plannedTrips ?? [];
  } else {
    return [];
  }
}

Future<void> getPlannedTrip() async {
  final plannedDB = await Hive.openBox<UserPlannedTrips>('plannedTrips');
  plannedTripNotifier.value.clear();
  plannedTripNotifier.value.addAll(plannedDB.values);
}


Future<bool> removeFromSave(
    String currentUser, String placeName, String imageUrl) async {
  final savedBox = await Hive.openBox<User>('users');
  final user = savedBox.get(currentUser);

  if (user != null && user.savedLocation != null) {
    final locationToRemove =
        UsersavedLocation(imagePath: imageUrl, placeName: placeName);

    // Use the indexWhere method to find the index of the locationToRemove
    final index = user.savedLocation!.indexWhere((location) =>
        location.imagePath == locationToRemove.imagePath &&
        location.placeName == locationToRemove.placeName);

    if (index != -1) {
      // Remove the location at the found index
      user.savedLocation!.removeAt(index);

      // Save the updated user object back to Hive
      savedBox.put(currentUser, user);

      return true;
    }
  }

  return false;
}

Future<User> getUserInfo(String username) async {
  final userInfoBox = await Hive.openBox<User>('users');
  final userInfo = await userInfoBox.get(username);
  if (userInfo == null) {
    throw Exception('user not found');
  } else {
    return userInfo;
  }
}

//update user

// Future<void>updateUser( String username, String password, String email, String mob, File imagePath)async{
//   final userBox = await Hive.openBox<User>('users');
//                         final updatedUser = User(
//                         username: username,
//                         password: password,
//                         email: email,
//                         mobileNum: mob,
//                         profilePic: (imagePath != null) ? imagePath.path : user!.profilePic,
//                         );

//                         userBox.put(widget.username, updatedUser);
//                         print('updated ${widget.username}');
// }

Future<void> deleteUser(String username) async {
  try {
    final userBox = await Hive.openBox<User>('users');
    final userToDelete = userBox.get(username);

    if (userToDelete != null) {
      await userBox.delete(username);
    }
    print('successfully deleted user $username');
  } catch (error) {
    print(error);
  }
}

void signout(BuildContext ctx) async {
  final _sharedPrefes = await SharedPreferences.getInstance();
  await _sharedPrefes.clear();
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => LoginScreen(),
      ),
      (route) => false);
  await Hive.close();
}

Future<void> addTransactionToPlace(String placeName, int amount, String desription, String plannedDate, String plannedImages, String plannedMembers, String plannedThings)async{
  try{
  final plannedBox = await Hive.openBox<UserPlannedTrips>('plannedTrips');
  var place = plannedBox.get(placeName) ?? UserPlannedTrips(plannedPlace: placeName, plannedAmount: amount.toString(), plannedDate: plannedDate, plannedImages: plannedImages, plannedMembers: plannedMembers, plannedThings: plannedThings);
  place.transactions ??= <Transactions>[];
  var newTransaction = Transactions(amt: amount, credit: desription);
  var modifiebleTransactions = List<Transactions>.from(place.transactions!);
  modifiebleTransactions.add(newTransaction);
  place.transactions = modifiebleTransactions;
  plannedBox.put(placeName, place);
  print('Transaction added successfully ');
  } catch (e){
    print(e);
  }
}

Future<List<Transactions>> getTransactions(String placeName)async{
  final plannedTrip = await Hive.openBox<UserPlannedTrips>('plannedTrips');
  final user = plannedTrip.get(placeName);
  if(user != null){
    return user.transactions ?? [];
  }else{
    return [];
  }
}
