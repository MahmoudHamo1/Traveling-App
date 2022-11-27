import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:trawell/utils/consts.dart';

class Shop  {

  String id = '';
  String name = '';
  String price = '';
  String location = '';
  String about = '';
  String userId = '';
  String averageLikes = '';
  String imageUrl = '';

  Shop(
      this.id,
      this.name,
      this.price,
      this.location,
      this.about,
      this.userId,
      this.averageLikes,
      this.imageUrl,
  );

}
