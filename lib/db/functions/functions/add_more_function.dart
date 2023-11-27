import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

Future<bool> addMorePlace(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<PlaceList>('places');
  final places = PlaceList(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to PlaceList',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
Future<bool> addBestPlaces(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<BestPlaces>('bestPlace');
  final places = BestPlaces(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to BestPlaces',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}

Future<bool> addMostVisited(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<MostVisited>('mostVisited');
  final places = MostVisited(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to MostVisted',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
Future<bool> addFavouritePlaces(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<Favourite>('favourite');
  final places = Favourite(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to Favourite',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
Future<bool> addNewAdded(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<NewAdded>('newAdded');
  final places = NewAdded(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to NewAdded',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
Future<bool> addFamous(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<Famous>('famous');
  final places = Famous(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to Famous',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
Future<bool> addHidden(String imageUrl, String placeName, String description, BuildContext context) async {
  final placeBox = await Hive.openBox<Hidden>('hidden');
  final places = Hidden(placeName: placeName, description: description, imageUrl: imageUrl);
  bool placeAny = placeBox.values.any((place) => place.placeName == placeName);
  if (placeAny) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('The place that you have entered is already exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    await placeBox.add(places);
    Fluttertoast.showToast(
      msg: 'Uploaded The Place to Hidden',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  return true;
}
