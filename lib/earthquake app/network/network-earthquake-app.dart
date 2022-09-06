import 'dart:convert';

import 'package:http/http.dart';

import '../model/model-earthquake-app.dart';

class EarthquakeAppNetworkClass {
  Future<EarthquakeModelClass> getAllEarthQuakes() async {
    String url =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      return EarthquakeModelClass.fromJson(json.decode(response.body));
    } else {
      throw Exception("error");
    }
  }
}
