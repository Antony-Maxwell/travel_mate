
import 'package:hive_flutter/hive_flutter.dart';
part 'category_data_model.g.dart';

@HiveType(typeId: 5)

class BestPlaces{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  BestPlaces({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

@HiveType(typeId: 6)

class MostVisited{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  MostVisited({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

@HiveType(typeId: 7)

class Favourite{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  Favourite({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

@HiveType(typeId: 8)

class NewAdded{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  NewAdded({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

@HiveType(typeId: 9)

class Famous{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  Famous({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}

@HiveType(typeId: 10)

class Hidden{
  @HiveField(0)
  String? placeName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  Hidden({
    required this.placeName,
    required this.description,
    required this.imageUrl,
  });
}