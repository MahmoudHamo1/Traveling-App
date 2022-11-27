import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:trawell/utils/consts.dart';

class Timeline  {

  String id = '';
  String title = '';
  String body = '';
  String userId = '';
  String averageLikes = '';
  String imageUrl = '';

  Timeline(
      this.id,
      this.title,
      this.body,
      this.userId,
      this.averageLikes,
      this.imageUrl
  );

}
