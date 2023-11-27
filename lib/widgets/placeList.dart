import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class ViewPlaceList extends StatelessWidget {
  const ViewPlaceList({super.key});

  Future<List<PlaceList>> getAll() async {
    final placeBox = await Hive.openBox<PlaceList>('places');
    return placeBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places List'),
      ),
      body: FutureBuilder<List<PlaceList>>(
        future: getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No places available.'));
          } else {
            final places = snapshot.data;
            return ListView.builder(
              itemCount: places!.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return ListTile(
                  title: Text(place.placeName ?? ''),
                  subtitle: Text(place.description ?? ''),
                  // Display other place details as needed.
                );
              },
            );
          }
        },
      ),
    );
  }
}
