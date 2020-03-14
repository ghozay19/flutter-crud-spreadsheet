import 'dart:convert';

import 'package:flutter_spreadsheet/model/student_present_response.dart';
import 'package:flutter_spreadsheet/model/status_response.dart';
import 'package:http/http.dart' as http;

class Services {
  String _status = '000';
  String _hasil = 'Gagal';

  Future<StatusResponse> postData(
      {String nis, String nama, String status}) async {
    try {
      print('masok');
      String url =
          'https://script.google.com/macros/s/AKfycbz31Os2irk-5WjrAJJHd3DaKrsWNUsRoayzUqLVeyY1yUw5BcaA/'
          'exec?action=insert&tableName=presensi&nis=$nis&nama=$nama&status=$status';

      final response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        final statusResponse = StatusResponse.fromJson(json);
        return statusResponse;
      } else {
        print('statusCode' + response.statusCode.toString());
        final finalResponse = StatusResponse(status: _status, hasil: _hasil);
        return finalResponse;
      }
    } catch (e) {
      print(e.toString);
      final finalResponse = StatusResponse(status: _status, hasil: e.toString());
      return finalResponse;
    }
  }

  // ignore: missing_return
  Future<StudentPresentResponse> getData() async {
    try {
      print('request get siswa ....');

      String url =
          'https://script.google.com/macros/s/AKfycbz31Os2irk-5WjrAJJHd3DaKrsWNUsRoayzUqLVeyY1yUw5BcaA/exec?action=read&tableName=presensi';

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('status code : ${response.statusCode}');
        Map json = jsonDecode(response.body);
        print(json.toString());
        final studentResponse = StudentPresentResponse.fromJson(json);
        return studentResponse;
      } else {
        print('statusCode' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<StatusResponse> updateData(
      {String nis, String nama, String status}) async {
    try {
      print('request update siswa ....');

      String url =
          'https://script.google.com/macros/s/AKfycbz31Os2irk-5WjrAJJHd3DaKrsWNUsRoayzUqLVeyY1yUw5BcaA/'
          'exec?action=update&tableName=presensi&nis=$nis&nama=$nama&status=$status';

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('status code : ${response.statusCode}');
        Map json = jsonDecode(response.body);
        print(json.toString());
        final studentResponse = StatusResponse.fromJson(json);
        return studentResponse;
      } else {
        print('statusCode' + response.statusCode.toString());
        final finalResponse = StatusResponse(status: _status, hasil: _hasil);
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      final finalResponse = StatusResponse(status: _status, hasil: e.toString());
      return finalResponse;
    }
  }

  Future<StatusResponse> deleteData({
  int nis,
}) async {
    try {
      print('request get siswa ....');

      String url =
          'https://script.google.com/macros/s/AKfycbz31Os2irk-5WjrAJJHd3DaKrsWNUsRoayzUqLVeyY1yUw5BcaA/'
          'exec?action=delete&tableName=presensi&nis=$nis';

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('status code : ${response.statusCode}');
        Map json = jsonDecode(response.body);
        print(json.toString());
        final studentResponse = StatusResponse.fromJson(json);
        return studentResponse;
      } else {
        print('statusCode' + response.statusCode.toString());
        final finalResponse = StatusResponse(status: _status, hasil: _hasil);
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      final finalResponse = StatusResponse(status: _status, hasil: e.toString());
      return finalResponse;
    }
  }
}
