class StatusResponse {
  String status;
  String hasil;

  StatusResponse({this.status, this.hasil});

  StatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hasil = json['hasil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hasil'] = this.hasil;
    return data;
  }
}