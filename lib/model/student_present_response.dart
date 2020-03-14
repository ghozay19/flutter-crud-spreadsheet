


class StudentPresentResponse {
  List<Present> present;

  StudentPresentResponse({this.present});

  StudentPresentResponse.fromJson(Map<String, dynamic> json) {
    if (json['presensi'] != null) {
      present = new List<Present>();
      json['presensi'].forEach((v) {
        present.add(new Present.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.present != null) {
      data['presensi'] = this.present.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Present {
  int nis;
  String nama;
  String status;

  Present({this.nis, this.nama, this.status});

  Present.fromJson(Map<String, dynamic> json) {
    nis = json['nis'];
    nama = json['nama'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nis'] = this.nis;
    data['nama'] = this.nama;
    data['status'] = this.status;
    return data;
  }
}