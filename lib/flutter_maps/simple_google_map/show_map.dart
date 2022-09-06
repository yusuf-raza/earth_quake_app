import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMaps extends StatefulWidget {
  const ShowMaps({Key? key}) : super(key: key);

  @override
  State<ShowMaps> createState() => _ShowMapsState();
}

class _ShowMapsState extends State<ShowMaps> {
  //declaring a map controller that we will use later
  late GoogleMapController myMapController;
  MapType _currentMapType = MapType.normal;

  //setting up the initial place to show when map is created
  static LatLng initialPlace = LatLng(24.8607, 67.0011);

  void onMApCreated(GoogleMapController controller) {
    myMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
                markers: {karachiMarker,lahoreMarker},
                mapToolbarEnabled: true,
                mapType: _currentMapType,
                onMapCreated: onMApCreated,
                initialCameraPosition:
                    CameraPosition(target: initialPlace, zoom: 11)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: changeMapType,
                    child: Icon(Icons.map, size: 36.0),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  )),
            ),
          ],
        ));
  }

  Marker karachiMarker = Marker(
    markerId: MarkerId("Karachi"),
    position: initialPlace,
    infoWindow: InfoWindow(title: "Karachi"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker lahoreMarker = Marker(
    markerId: MarkerId("Lahore"),
    position: LatLng(31.4832209, 74.0541892),
    infoWindow: InfoWindow(title: "Lahore"),
    icon: BitmapDescriptor.defaultMarker,
  );

  void changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
}
