import 'package:cargpstracker/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:async';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:developer';

class mapLive extends StatefulWidget {
  mapLive({Key? key}) : super(key: key);

  @override
  _mapLiveState createState() => _mapLiveState();
}

class _mapLiveState extends State<mapLive> {
  late LatLng pos = new LatLng(41.025819, 29.230415);
  late MapboxMapController mapController;
  // ignore: unused_field
  late Timer _timer;
  var currentIndex = 0;
  var points = <LatLng>[
    new LatLng(41.025819, 29.230415),
    new LatLng(41.026198, 29.230873),
    new LatLng(41.026043, 29.231208),
    new LatLng(41.025896, 29.231477),
    new LatLng(41.026175, 29.231887),
    new LatLng(41.026261, 29.232164),
    new LatLng(41.026261, 29.232164),
  ];

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onMapCliked(LatLng latlon) {}

  void fetch(index) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://185.208.175.202:1600/live/'));
    request.fields.addAll({'id': '1'});
    print('request start');
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // debugPrint(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    // return const
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        mapController.clearCircles();
        if (currentIndex < 6)
          currentIndex++;
        else
          currentIndex = 0;

        pos = points[currentIndex];
        // mapController.addCircle(
            // CircleOptions(circleColor: 'blue', geometry: pos, circleRadius: 8));
      });
      fetch(currentIndex);
      // print('ahamad');
    });

    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6, // 20%
          child: Container(
            color: Colors.blue,
            child: MapboxMap(
                accessToken: MyApp.ACCESS_TOKEN,
                onMapCreated: _onMapCreated,
                onMapClick: (point, latlng) {
                  String msg =
                      'lat = ${latlng.latitude} & lon = ${latlng.longitude}';
                  print(msg);
                  Fluttertoast.showToast(msg: msg);
                },
                onStyleLoadedCallback: () => addCircle(mapController),
                initialCameraPosition: CameraPosition(target: pos, zoom: 20)),
          ),
        ),
      ],
    );
  }

  void addCircle(MapboxMapController controller) {
    controller.addCircle(
        CircleOptions(circleColor: 'blue', geometry: pos, circleRadius: 8));
  }
}

class $ {}