
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_mate/screens/bottom_menu_screens/userInputPlace.dart';

class location_googleMap extends StatefulWidget {
  location_googleMap({required this.placeName});
  final String placeName;

  @override
  State<location_googleMap> createState() => _location_googleMapState();
}

class _location_googleMapState extends State<location_googleMap> {

  Set<Marker> _markers = {};
  StreamSubscription<LocationData>? _locationSubscription;
  TextEditingController start = TextEditingController();
  // List<LatLng> routPoints = [LatLng(9.931233, 76.267303)];
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng? _currentP = null;
  LatLng? _destinationP;
  List<LatLng> routeCoordinates = [];
  GoogleMapController? _controller;
  bool isVisible = false;
  MapType map = MapType.normal;

  // static const CameraPosition _kGooglePlex ;

  @override
  void initState() {
    super.initState();
    if(start.text.isEmpty || start.text == null){
      setupLocationSubscription();
    }else{
      _setUserSavedLocation();
    }
    
  }

  @override
  void dispose() {
    disposeLocationSubscription();
    super.dispose();
  }

  void setupLocationSubscription() {
    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  void disposeLocationSubscription() {
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SizedBox(
                  height: 750,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: _currentP == null
                            ? Center(
                                child: Text(
                                  'Loading',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : GoogleMap(
                                onMapCreated:
                                    ((GoogleMapController controller) =>
                                        _mapController.complete(controller)),
                                mapType: map,
                                initialCameraPosition: CameraPosition(
                                  target: _destinationP ?? _currentP!,
                                  zoom: 15,
                                ),
                                polylines: Set<Polyline>.of(
                                  <Polyline>[
                                    Polyline(
                                      polylineId: PolylineId("route"),
                                      color: Colors.blue,
                                      width: 5,
                                      points: routeCoordinates,
                                    )
                                  ],
                                ),
                                markers: {
                                  Marker(
                                      markerId: MarkerId("_currentLocation"),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueCyan),
                                      position: _currentP!,
                                      infoWindow: InfoWindow(
                                        title: 'Current Location',
                                        anchor: Offset(00, 00),
                                      )),
                                  if (_destinationP != null)
                                    Marker(
                                      markerId:
                                          MarkerId("_destinationLocation"),
                                      icon: BitmapDescriptor.defaultMarker,
                                      position: _destinationP!,
                                      infoWindow: InfoWindow(
                                        title: '${start.text}',
                                      ),
                                    ),
                                },
                              ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 5,
                                          ),
                                          child: myInput(
                                            controller: start,
                                            hint: 'Enter your destination',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _setUserDestinationMarker();
                                          _setUserSavedLocation();
                                          print('successfully');
                                        },
                                        child: Icon(Icons.directions),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              FloatingActionButton.small(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      width: double.infinity,
                                      height: 152,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Select your prefered style',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Divider(),
                                          Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          map = MapType.hybrid;
                                                        });
                                                      },
                                                      child: Text(
                                                          'Set Map to Satellite'),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          map = MapType.normal;
                                                        });
                                                      },
                                                      child: Text(
                                                          'Set Map to Normal'),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.layers,
                                  size: 30,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setUserDestinationMarker() async {
    try{
    if (start.text.isNotEmpty) {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(start.text);
      print('oomb $locations');
      if (locations.isNotEmpty) {
        final geocoding.Location destinationLocation = locations.first;
        final LatLng userDestination = LatLng(
          destinationLocation.latitude,
          destinationLocation.longitude,
        );
        print('place ${destinationLocation.latitude}');

        final MarkerId destinationMarkerId = MarkerId("_destinationLocation");
        final Marker destinationMarker = Marker(
          markerId: destinationMarkerId,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: userDestination,
        );

        if (_destinationP != null) {
          setState(() {
            _markers.removeWhere(
                (marker) => marker.markerId.value == "_destinationLocation");
          });
        }

        setState(() {
          _destinationP = userDestination;
          _markers.add(destinationMarker);
        });

        await _cameraToPosition(_destinationP!);
      } else {
        print('Location not found');
      }
    }
    }catch (e){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text('Could not find any result for the supplied address'),
        );
      },);
    }
  }

  Future<void> _setUserSavedLocation() async {
    try{
    start.text = widget.placeName;
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(start.text);
    print('oomb $locations');
    if (locations.isNotEmpty) {
      final geocoding.Location destinationLocation = locations.first;
      final LatLng userDestination = LatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      );
      print('place ${destinationLocation.latitude}');

      final MarkerId destinationMarkerId = MarkerId("_destinationLocation");
      final Marker destinationMarker = Marker(
        markerId: destinationMarkerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: userDestination,
      );

      if (_destinationP != null) {
        setState(() {
          _markers.removeWhere(
              (marker) => marker.markerId.value == "_destinationLocation");
        });
      }

      setState(() {
        _destinationP = userDestination;
        _markers.add(destinationMarker);
      });

      await _cameraToPosition(_destinationP!);
    } else {
      print('Location not found');
    }
    }catch (e){
      
    }
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

  try{
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    StreamSubscription<LocationData> locationSubscription;

    locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {}
    });
    _locationSubscription = locationSubscription;
  }catch (e){
    return 
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text('Error'),
        title: Text('Errorrrrrrrrrrrrrrrrrrrrr'),
      );
    },);
  }
  }
}
