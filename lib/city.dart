import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lets_head_out/utils/consts.dart';

class City  {

  String id;
  String name;
  String location;
  String about;
  String userId;

  City(String id, String name, String location, String about, String useId) {
    this.id = id;
    this.name = name;
    this.location = location;
    this.about = about;
    this.userId = useId;
  }

}
