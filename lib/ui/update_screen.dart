import 'package:flutter/material.dart';
import 'package:flutter_spreadsheet/model/status_response.dart';
import 'package:flutter_spreadsheet/model/student_present_response.dart';
import 'package:flutter_spreadsheet/services/services.dart';
import 'package:flutter_spreadsheet/widget/notif.dart';

class UpdateScreen extends StatefulWidget {
  final Present present;
  UpdateScreen({this.present});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  Services services;
  final _nama = TextEditingController();
  final _nis = TextEditingController();
  final _presensi = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    services = Services();
    _nama.text = widget.present.nama;
    _nis.text = widget.present.nis.toString();
    _presensi.text = widget.present.status;

    isLoading = false;
    super.initState();
  }

  Future<StatusResponse> updateData() async {
    setState(() {
      isLoading = true;
    });
      final response = await services.updateData(
          nis: _nis.text, nama: _nama.text, status: _presensi.text);

      if (response.status == "1") {
        setState(() {
          isLoading = false;
        });

        showSuccess(context, response.hasil);
        return response;
      } else {
        setState(() {
          isLoading = false;
        });

        showError(context, response.hasil);
        return response;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
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
              isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Kirim ❤',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await updateData();
                      }),
              RaisedButton(onPressed: ()=> Navigator.pop(context))
            ],
          ),
        ),
      ),
    );
  }
}
