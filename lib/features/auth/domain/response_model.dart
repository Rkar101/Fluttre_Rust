class ResponseModel {
  final int status;
  final bool state;
  final String msg;

  ResponseModel({required this.status, required this.state, required this.msg});

  factory ResponseModel.fromJson(Map<String , dynamic> json) {
    return ResponseModel(status: json["status"], state: json["state"], msg: json["msg"]);
  }
}
