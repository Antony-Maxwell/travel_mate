// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BestPlacesAdapter extends TypeAdapter<BestPlaces> {
  @override
  final int typeId = 5;

  @override
  BestPlaces read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BestPlaces(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BestPlaces obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BestPlacesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MostVisitedAdapter extends TypeAdapter<MostVisited> {
  @override
  final int typeId = 6;

  @override
  MostVisited read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostVisited(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MostVisited obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostVisitedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouriteAdapter extends TypeAdapter<Favourite> {
  @override
  final int typeId = 7;

  @override
  Favourite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourite(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Favourite obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewAddedAdapter extends TypeAdapter<NewAdded> {
  @override
  final int typeId = 8;

  @override
  NewAdded read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewAdded(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewAdded obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewAddedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FamousAdapter extends TypeAdapter<Famous> {
  @override
  final int typeId = 9;

  @override
  Famous read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Famous(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Famous obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamousAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiddenAdapter extends TypeAdapter<Hidden> {
  @override
  final int typeId = 10;

  @override
  Hidden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hidden(
      placeName: fields[0] as String?,
      description: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hidden obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiddenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
