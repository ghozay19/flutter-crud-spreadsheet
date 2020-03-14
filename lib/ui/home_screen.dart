import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spreadsheet/ui/presensi_screen.dart';
import 'package:flutter_spreadsheet/ui/siswa_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter CRUD ❤')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(onPressed:(){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => PresensiScreen()));
                  },
                color: Colors.greenAccent,
                  child: Text('Tambah Data'),
                ),

                RaisedButton(onPressed:(){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => SiswaScreen()));
                },
                  color: Colors.greenAccent,
                  child: Text('Lihat Data'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
