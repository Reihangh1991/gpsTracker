import 'dart:core';
import 'package:cargpstracker/mapHistory.dart';
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

class _HistoryState extends State<History>
    with AutomaticKeepAliveClientMixin<History> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build saam');
    return Scaffold(
        body: Container(
      width: 1500,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 54, 170),
      ),
      child: mapHistory(),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
