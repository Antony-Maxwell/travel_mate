// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[0] as String?,
      password: fields[1] as String?,
      savedLocation: (fields[2] as List?)?.cast<UsersavedLocation>(),
      plannedTrips: (fields[3] as List?)?.cast<UserPlannedTrips>(),
      uploadedPlaces: (fields[4] as List?)?.cast<PlaceList>(),
      profilePic: fields[5] as String?,
      email: fields[6] as String?,
      mobileNum: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.savedLocation)
      ..writeByte(3)
      ..write(obj.plannedTrips)
      ..writeByte(4)
      ..write(obj.uploadedPlaces)
      ..writeByte(5)
      ..write(obj.profilePic)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.mobileNum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsersavedLocationAdapter extends TypeAdapter<UsersavedLocation> {
  @override
  final int typeId = 1;

  @override
  UsersavedLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersavedLocation(
      imagePath: fields[0] as String,
      placeName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersavedLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.placeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersavedLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaceListAdapter extends TypeAdapter<PlaceList> {
  @override
  final int typeId = 3;

  @override
  PlaceList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceList(
      id: fields[0] as int?,
      placeName: fields[1] as String?,
      description: fields[2] as String?,
      imageUrl: fields[3] as String?,
      status: fields[4] as PlaceStatus?,
      comments: (fields[6] as List?)?.cast<Comments>(),
      rating: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceList obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.placeName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserPlannedTripsAdapter extends TypeAdapter<UserPlannedTrips> {
  @override
  final int typeId = 4;

  @override
  UserPlannedTrips read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPlannedTrips(
      plannedPlace: fields[0] as String?,
      plannedAmount: fields[2] as String?,
      plannedDate: fields[3] as String?,
      plannedImages: fields[5] as String?,
      plannedMembers: fields[1] as String?,
      plannedThings: fields[4] as String?,
      transactions: (fields[6] as List?)?.cast<Transactions>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserPlannedTrips obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.plannedPlace)
      ..writeByte(1)
      ..write(obj.plannedMembers)
      ..writeByte(2)
      ..write(obj.plannedAmount)
      ..writeByte(3)
      ..write(obj.plannedDate)
      ..writeByte(4)
      ..write(obj.plannedThings)
      ..writeByte(5)
      ..write(obj.plannedImages)
      ..writeByte(6)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPlannedTripsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommentsAdapter extends TypeAdapter<Comments> {
  @override
  final int typeId = 11;

  @override
  Comments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comments(
      commentText: fields[1] as String?,
      timestamp: fields[2] as DateTime?,
      userName: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Comments obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.commentText)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionsAdapter extends TypeAdapter<Transactions> {
  @override
  final int typeId = 14;

  @override
  Transactions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transactions(
      amt: fields[1] as int?,
      credit: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Transactions obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.credit)
      ..writeByte(1)
      ..write(obj.amt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
