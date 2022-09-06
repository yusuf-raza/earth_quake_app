import 'dart:async';
import 'package:earth_quake_app/earthquake%20app/model/model-earthquake-app.dart';
import 'package:earth_quake_app/earthquake%20app/network/network-earthquake-app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class EarthQuakeApp extends StatefulWidget {
  const EarthQuakeApp({Key? key}) : super(key: key);

  @override
  State<EarthQuakeApp> createState() => _EarthQuakeAppState();
}

class _EarthQuakeAppState extends State<EarthQuakeApp> {

  late Future<EarthquakeModelClass> _quakes;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    _quakes = EarthquakeAppNetworkClass().getAllEarthQuakes();
    //quakes.then((value) => print("Place: ${value.features![0].properties!.place}"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _buildGoogleMaps(context),
          
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(label: Text("Get Earthquakes"),onPressed: (){
        _findQuakes();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildGoogleMaps(context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child :GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controler){
          _controller.complete(controler);
        },
        initialCameraPosition: CameraPosition(target: LatLng(31.4832209, 74.0541892),zoom: 3),
        markers: Set<Marker>.of(markers),
      )
    );
  }

  void _findQuakes() {
      setState(() {
        //to make sure that the map is clear of markers in beginning
        markers.clear();

        _handleMarkerResponse();
      });
  }

  void _handleMarkerResponse() {
    setState(() {
      _quakes.then((value) => {
        value.features!.forEach((element) {

          markers.add(Marker(
            markerId: MarkerId(element.id!),
            infoWindow: InfoWindow(title: element.properties!.mag.toString(),snippet:element.properties!.title.toString() ),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(element.geometry!.coordinates![1], element.geometry!.coordinates![0]),
            onTap: (){},
          ));
        })
      });
    });
  }




}
