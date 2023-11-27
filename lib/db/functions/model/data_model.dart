import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String? username;

  @HiveField(1)
  final String? password;

  @HiveField(2)
  List<UsersavedLocation>? savedLocation;

  @HiveField(3)
  List<UserPlannedTrips>? plannedTrips;

  @HiveField(4)
  List<PlaceList>? uploadedPlaces;

  @HiveField(5)
  final String? profilePic;

  @HiveField(6)
  final String? email;

  @HiveField(7)
  final String? mobileNum;

  User({
    required this.username,
    required this.password,
    this.savedLocation = const [],
    this.plannedTrips = const [],
    this.uploadedPlaces = const [],
    this.profilePic,
    required this.email,
    this.mobileNum,
  });
}


@HiveType(typeId:1)
class UsersavedLocation {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String? placeName;

  UsersavedLocation({required this.imagePath, required this.placeName});

  
  
}

@HiveType(typeId: 3)
class PlaceList{
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? placeName;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? imageUrl;

  @HiveField(4)
  PlaceStatus? status;

  @HiveField(6)
  List<Comments>? comments;

  @HiveField(7)
  double? rating;

  PlaceList({
    this.id,
    required this.placeName,
    required this.description,
    required this.imageUrl,
    this.status,
    this.comments = const [],
    this.rating,
  }
  );

}

enum PlaceStatus{
  placeAccepted,
  placeRejected,
  placePending,
}

class PlaceStatusAdapter extends TypeAdapter<PlaceStatus>{
  @override
  final int typeId = 12;

  @override
  PlaceStatus read(BinaryReader reader){
    return PlaceStatus.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, PlaceStatus placeStatus){
    writer.writeByte(placeStatus.index);
  }
}

@HiveType(typeId: 4)
class UserPlannedTrips{
  @HiveField(0)
  String? plannedPlace;

  @HiveField(1)
  String? plannedMembers;

  @HiveField(2)
  String? plannedAmount;

  @HiveField(3)
  String? plannedDate;

  @HiveField(4)
  String? plannedThings;

  @HiveField(5)
  String? plannedImages;

  @HiveField(6)
  List<Transactions>? transactions;


  UserPlannedTrips({
    required this.plannedPlace,
    required this.plannedAmount,
    required this.plannedDate,
    required this.plannedImages,
    required this.plannedMembers,
    required this.plannedThings,
    this.transactions = const [],
});
}

@HiveType(typeId: 11)
class Comments{
  @HiveField(0)
  String? userName;

  @HiveField(1)
  String? commentText;

  @HiveField(2)
  DateTime? timestamp;

  Comments({
    required this.commentText,
    required this.timestamp,
    required this.userName,
  });
}

@HiveType(typeId: 14)
class Transactions{
  @HiveField(0)
  String? credit;

  @HiveField(1)
  int? amt;

  Transactions({
    required this.amt,
    required this.credit,
  });
}

