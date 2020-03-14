import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spreadsheet/model/status_response.dart';
import 'package:flutter_spreadsheet/model/student_present_response.dart';
import 'package:flutter_spreadsheet/services/services.dart';
import 'package:flutter_spreadsheet/ui/update_screen.dart';
import 'package:flutter_spreadsheet/widget/notif.dart';

class SiswaScreen extends StatefulWidget {
  @override
  _SiswaScreenState createState() => _SiswaScreenState();
}

class _SiswaScreenState extends State<SiswaScreen> {
  Services _services;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _services = Services();
    isLoading = false;
    super.initState();
  }

  void confirm(Present present) {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Are You sure want to delete '${present.nama}'"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData(present.nis);
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          child: Text("CANCEL", style: TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  Future<StatusResponse> deleteData(int nis) async {
    setState(() {
      isLoading = true;
    });
    final response = await _services.deleteData(nis: nis);

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Siswa Screen'),
      ),
      body: FutureBuilder<StudentPresentResponse>(
        future: _services.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data.present.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data.present[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(data.nama),
                          subtitle: Text('NIS ${data.nis}'),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => UpdateScreen(
                                          present: data,
                                        )));
                          },
                          onLongPress: () {
                            confirm(data);
                          },
                        ));
                  });
            } else {
              return Center(child: Text('kosong'));
            }
          }
        },
      ),
    );
  }
}
