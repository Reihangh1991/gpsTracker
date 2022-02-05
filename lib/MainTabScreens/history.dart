import 'dart:core';
import 'package:cargpstracker/maplive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'dart:developer';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

void fetch() async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://185.208.175.202:4680/live/'));
  request.fields.addAll({'id': '4'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class _HistoryState extends State<History>
    with AutomaticKeepAliveClientMixin<History> {
  @override
  void initState() {
    super.initState();
    print('initState saam');
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    print('build saam');
    return Scaffold(
        body: Container(
      width: 900,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 54, 170),
      ),
      child: mapLive(),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
