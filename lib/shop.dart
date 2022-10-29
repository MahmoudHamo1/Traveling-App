import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lets_head_out/utils/consts.dart';

class Shop  {

  String id;
  String name;
  String price;
  String location;
  String about;
  String userId;

  Shop(String id, String name, String price, String location, String about, String useId) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.location = location;
    this.about = about;
    this.userId = useId;
  }

}
