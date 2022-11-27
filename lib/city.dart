import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:trawell/utils/consts.dart';

class City  {

  String id = '';
  String name= '';
  String location= '';
  String about= '';
  String userId= '';
  String averageLikes= '';
  String imageUrl= '';

  City(
      this.id,
      this.name,
      this.location,
      this.about,
      this.userId,
      this.averageLikes,
      this.imageUrl
  );

}
