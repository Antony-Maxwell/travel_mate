import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/functions/search_funcrions.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/widgets/detailedPageWidgets/detailedPage.dart';
class SearchedPlace extends StatefulWidget {
  const SearchedPlace({Key? key});

  @override
  _SearchedPlaceState createState() => _SearchedPlaceState();
}

class _SearchedPlaceState extends State<SearchedPlace> {
  final _searchedPlace = TextEditingController();
  List<PlaceData> searchResults = []; // Store search results here

  @override
  void initState() {
    super.initState();
    _searchedPlace.addListener(_onSearchTextChanged);
    SearchMethod("");
  }

  @override
  void dispose() {
    _searchedPlace.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged()async {
    final query = _searchedPlace.text.toLowerCase();
    final filteredResults = await SearchMethod(query);
    setState(() {
      searchResults = filteredResults;
    });
  }

  Future<List<PlaceData>> SearchMethod(String query)async {
    final List<PlaceData> results = [];
    // Search in each Hive box and add matching places to results
    results.addAll(await searchInBestPlaces(query));
    results.addAll(await searchInMostVisited(query));
    results.addAll(await searchInFavourite(query));
    results.addAll(await searchInNewAdded(query));
    results.addAll(await searchInFamous(query));
    results.addAll(await searchInMainPlace(query));
    // Add other boxes as needed

    return results;
  }

  // Add similar methods for other Hive boxes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios,
                color: Colors.white,
                size: 35,))),
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    controller: _searchedPlace,
                    style: TextStyle(
                      color: Color.fromARGB(255, 206, 205, 205),
                    ),
                    decoration: InputDecoration(
                      labelText: "Search here",
                      labelStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final place = searchResults[index];

                  // Use a try-catch block to handle potential exceptions during file operations
                  try {
                    Widget imageWidget = place.imageUrl.startsWith('assets/')
                        ? Image.asset(
                            place.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(place.imageUrl),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );

                    return Card(
                      borderOnForeground: true,
                      color: Color.fromARGB(255, 121, 121, 121),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedPage(
                                    ratingTotal: 0,
                                    imageAssetPath: place.imageUrl,
                                    placeName: place.placeName,
                                    description: place.description,
                                  ),
                                ),
                              );
                            },
                            leading: imageWidget,
                            title: Text(place.placeName),
                            subtitle: Text('Read More >'),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    // Handle the exception, e.g., log the error or show a placeholder image
                    return Card(
                      // Add appropriate styling for error card
                      child: Text('Error loading image'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
