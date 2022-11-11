import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lets_head_out/utils/consts.dart';

class Timeline  {

  String id;
  String title;
  String body;
  String userId;

  Timeline(String id, String title, String body, String useId) {
    this.id = id;
    this.title = title;
    this.body = body;
    this.userId = useId;
  }

}
