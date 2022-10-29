import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lets_head_out/utils/consts.dart';

class Customer  {

  Customer._privateConstructor();
  static final Customer _instance  = Customer._privateConstructor();

  String id = '';
  String name = '';
  String email = '';
  String password = '';

  factory Customer() {
    return _instance ;
  }

  Future <BackendMessage> loginToBackend(String email, String password) async {
    Response response = await post(Uri.parse("https://travelingapp.000webhostapp.com/singin.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: " + jsonResponse['message'].toString());
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.password = jsonResponse['message']['password'];
    }

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> signupToBackend(String name, String email, String password) async {
    Response response = await post( Uri.parse("https://travelingapp.000webhostapp.com/singup.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': name, 'email': email, 'password': password })
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.password = jsonResponse['message']['password'];
    }

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> updateName(String name) async {
    Response response = await post( Uri.parse("https://travelingapp.000webhostapp.com/update_name.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': name, 'email': email})
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.name = name;
    }
    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> updatePassword(String password) async {
    Response response = await post( Uri.parse("https://travelingapp.000webhostapp.com/update_password.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'password': password, 'email': email})
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.password = password;
    }
    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
}

class BackendMessage {
  String status;
  String message;

  BackendMessage(String status, String message) {
    this.status = status;
    this.message = message;
  }

}