
import 'package:cargpstracker/maplive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting>
    with AutomaticKeepAliveClientMixin<Setting> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
  }

// Jalali picked = await showPersianDatePicker(
//     context: context,
//     initialDate: Jalali.now(),
//     firstDate: Jalali(1385, 8),
//     lastDate: Jalali(1450, 9),
// );
  @override
  Widget build(BuildContext context) {
    Jalali tempPickedDate;
    return Scaffold(
        body: Row(
      children: [
        Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(children: <Widget>[
              Container(
                  width: 300,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    color: Colors.red,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Standby mode',
                        style: TextStyle(fontSize: 30),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: Color.fromARGB(255, 179, 230, 122),
                        activeColor: Color.fromARGB(255, 184, 219, 185),
                      ),
                    ],
                  )),
              Container(
                  width: 300,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    color: Colors.red,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'speed limit',
                        style: TextStyle(fontSize: 30),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  )),
            ])),
        Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Container(
              width: 700,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 54, 170),
              ),
              child: mapLive(),
            )),
             ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}