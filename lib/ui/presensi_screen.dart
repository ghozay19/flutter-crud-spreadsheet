import 'package:flutter/material.dart';
import 'package:flutter_spreadsheet/model/status_response.dart';
import 'package:flutter_spreadsheet/services/services.dart';
import 'package:flutter_spreadsheet/widget/notif.dart';

class PresensiScreen extends StatefulWidget {
  @override
  _PresensiScreenState createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  Services services;

  final _nama = TextEditingController();
  final _nis = TextEditingController();
  final _presensi = TextEditingController();

  bool isLoading = false ;

  @override
  void initState() {
    super.initState();
    services = Services();
    isLoading = false;
  }

  Future<StatusResponse> createdata() async {
    setState(() {
      isLoading = true;
    });
    try{
      final response = await services.postData(
          nis: _nis.text, nama: _nama.text, status: _presensi.text);

      print(response.toJson().toString());

      if (response.status == "1") {
        setState(() {
          isLoading = false;
          _nis.clear();
          _nama.clear();
          _presensi.clear();

        });
        showSuccess(context, response.hasil);
      } else {
        setState(() {
          isLoading = false;
        });

        showError(context, response.hasil);


      }
    }catch(e){
       print(e.toString());

       setState(() {
         isLoading = false;
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Tambah Presensi')
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NIS',
                ),
                controller: _nis,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'NAMA',
                ),
                controller: _nama,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'PRESENSI',
                ),
                controller: _presensi,
              ),
              SizedBox(
                height: 20,
              ),
              isLoading ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                color: Colors.white.withOpacity(0.8),
              ) : RaisedButton(
                color: Colors.blue,
                  child: Text('Kirim ❤', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                createdata();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
