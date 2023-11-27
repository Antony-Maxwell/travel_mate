import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';

// Future openHive()async{
//   await Hive.openBox<BestPlaces>('bestPlace');
//   await Hive.openBox('mostVisited');
//   await Hive.openBox('favourite');
//   await Hive.openBox('newAdde')
// }
Future<List<PlaceData>> searchInBestPlaces(String query) async {
  final box = await Hive.openBox<BestPlaces>('bestPlace');

  try {
    return box.values
        .where((place) {
          final placeName = place.placeName?.toLowerCase();
          final description = place.description?.toLowerCase();
          return placeName!.contains(query) || description!.contains(query);
        })
        .map((place) => PlaceData(
              placeName: place.placeName!,
              description: place.description!,
              imageUrl: place.imageUrl!,
            ))
        .toList();
  } finally {
    await box.close();
  }
}

Future<List<PlaceData>> searchInMostVisited(String query) async{
  // final box = Hive.box<MostVisited>('mostVisited');
  final box = await Hive.openBox<MostVisited>('mostVisited');
  try{
  return box.values
      .where((place) {
        final placeName = place.placeName?.toLowerCase();
        final description = place.description?.toLowerCase();
        return placeName!.contains(query) || description!.contains(query);
      })
      .map((place) => PlaceData(
          placeName: place.placeName!,
          description: place.description!,
          imageUrl: place.imageUrl!))
      .toList();
  }finally{
    await box.close();
  }
}

Future<List<PlaceData>> searchInFavourite(String query) async{
  // final box = Hive.box<Favourite>('favourite');
  final box = await Hive.openBox<Favourite>('favourite');
  try{
  return box.values
      .where((place) {
        final placeName = place.placeName?.toLowerCase();
        final description = place.description?.toLowerCase();
        return placeName!.contains(query) || description!.contains(query);
      })
      .map((place) => PlaceData(
          placeName: place.placeName!,
          description: place.description!,
          imageUrl: place.imageUrl!))
      .toList();
  }finally {
    await box.close();
  }
}

Future<List<PlaceData>> searchInNewAdded(String query) async{
  // final box = Hive.box<NewAdded>('newAdded');
  final box = await Hive.openBox<NewAdded>('newAdded');
  try{
  return box.values
      .where((place) {
        final placeName = place.placeName?.toLowerCase();
        final description = place.description?.toLowerCase();
        return placeName!.contains(query) || description!.contains(query);
      })
      .map((place) => PlaceData(
          placeName: place.placeName!,
          description: place.description!,
          imageUrl: place.imageUrl!))
      .toList();
  }finally{
    await box.close();
  }
}

Future<List<PlaceData>> searchInFamous(String query)async {
  // final box = Hive.box<Famous>('famous');
  final box = await Hive.openBox<Famous>('famous');
  try{
  return box.values
      .where((place) {
        final placeName = place.placeName?.toLowerCase();
        final description = place.description?.toLowerCase();
        return placeName!.contains(query) || description!.contains(query);
      })
      .map((place) => PlaceData(
          placeName: place.placeName!,
          description: place.description!,
          imageUrl: place.imageUrl!))
      .toList();
  }finally{
    await box.close();
  }
}

Future<List<PlaceData>> searchInMainPlace(String query) async{
  // final box = Hive.box<PlaceList>('places');
  final box = await Hive.openBox<PlaceList>('places');
  try{
  return box.values
      .where((place) {
        final placeName = place.placeName?.toLowerCase();
        final description = place.description?.toLowerCase();
        return placeName!.contains(query) || description!.contains(query);
      })
      .map((place) => PlaceData(
          placeName: place.placeName!,
          description: place.description!,
          imageUrl: place.imageUrl!))
      .toList();
  }finally{
    await box.close();
  }
}
