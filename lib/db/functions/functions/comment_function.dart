import 'package:hive/hive.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

// import 'package:hive/hive.dart';
Future<void> addCommentToPlace(String placeName, String userName, String commentText,String description, String url) async {
  try {
    final placeListBox = await Hive.openBox<PlaceList>('places');
    var place = placeListBox.get(placeName) ?? PlaceList(placeName: placeName, description: description, imageUrl: url);
    place.comments ??= <Comments>[];
    var newComment = Comments(
      userName: userName,
      commentText: commentText,
      timestamp: DateTime.now(),
    );
    var modifiableComments = List<Comments>.from(place.comments!);
    modifiableComments.add(newComment);
    place.comments = modifiableComments;
    placeListBox.put(placeName, place);

    print('Comment added successfully: $commentText');
  } catch (e) {
    print('Error adding comment: $e');
  }
}

Future<List<Comments>>getComments(String placeName)async{
  final commentBox = await Hive.openBox<PlaceList>('places');
  final place = commentBox.get(placeName);
  if(place != null){
    return place.comments ?? [];
  }else{
    return [];
  }
}



