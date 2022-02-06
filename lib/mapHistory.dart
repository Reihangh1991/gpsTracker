import 'dart:convert';
import 'dart:io';

import 'package:cargpstracker/main.dart';
import 'package:cargpstracker/models/point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:async';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class mapHistory extends StatefulWidget {
  mapHistory({Key? key}) : super(key: key);

  @override
  _mapHistoryState createState() => _mapHistoryState();
}

class _mapHistoryState extends State<mapHistory> {
  late LatLng pos = new LatLng(41.025819, 29.230415);
  late MapboxMapController mapController;
  var currentIndex = 1;
  List<Point> dirArr = [];

  late Jalali tempPickedDate;
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onMapCliked(LatLng latlon) {}
  void _add() {
    mapController.clearLines();
    List<LatLng> points = [];
    for (Point point in dirArr) {
      points.add(LatLng(point.getLat(), point.getLon()));
    }
    mapController.addSymbol(
      SymbolOptions(
          geometry: LatLng(
            points[0].latitude,
            points[0].longitude,
          ),
          iconImage: './assets/icons/saam.jpg'),
    );
    mapController.addLine(
      LineOptions(
          geometry: points,
          lineColor: "#ff0000",
          lineWidth: 8.0,
          lineOpacity: 1.0,
          draggable: true),
    );
     mapController.addSymbol(
      SymbolOptions(
          geometry: LatLng(
            points[points.length-1].latitude,
            points[points.length-1].longitude,
          ),
          iconImage: './assets/icons/saam.jpg'),
    );
  }

  void fetch(String stamp) async {
    try {
      dirArr.clear();
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://185.208.175.202:1600/history/'));
      request.fields.addAll({'id': '4', 'timestamp': stamp});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final json = jsonDecode(responseString);
        for (var age in json["features"]) {
          Point p = Point.fromJson(age);
          dirArr.add(p);
        }
        _add();
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error add project $error');
    }
  }

  @override
  void initState() {
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
          flex: 7,
          child: Container(
            color: Colors.blue,
            child: MapboxMap(
                accessToken: MyApp.ACCESS_TOKEN,
                onMapCreated: _onMapCreated,
                onMapClick: (point, latlng) {
                  // String msg =
                  //     'lat = ${latlng.latitude} & lon = ${latlng.longitude}';
                  // print(msg);
                  // Fluttertoast.showToast(msg: msg);
                },
                onStyleLoadedCallback: () => fetch('1643779200'),
                initialCameraPosition: CameraPosition(target: pos, zoom: 13)),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              height: 250,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                          child: Text(
                            'لغو',
                            style: TextStyle(
                              fontFamily: 'Dana',
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child: Text(
                            'تایید',
                            style: TextStyle(
                              fontFamily: 'Dana',
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle:
                                TextStyle(fontFamily: "Dana"),
                          ),
                        ),
                        child: PCupertinoDatePicker(
                          mode: PCupertinoDatePickerMode.dateAndTime,
                          onDateTimeChanged: (Jalali dateTime) {
                            tempPickedDate = dateTime;
                            Timestamp myTimeStamp = Timestamp.fromDate(
                                tempPickedDate.toDateTime()); //To TimeStamp

                            fetch(myTimeStamp.seconds.toString());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

class $ {}
