import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:trawell/utils/consts.dart';

class Customer  {

  Customer._privateConstructor();
  static final Customer _instance  = Customer._privateConstructor();

  String id = '';
  String name = '';
  String email = '';
  String password = '';
  String imageUrl = '';

  factory Customer() {
    return _instance ;
  }

  Future <BackendMessage> loginToBackend(String email, String password) async {
    Response response = await post(Uri.parse("https://travelingapp2.000webhostapp.com/singin.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({'email': email, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: " + jsonResponse['message'].toString());
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.imageUrl = jsonResponse['message']['image_url'];
      this.password = jsonResponse['message']['password'];
    }

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> signupToBackend(String name, String email, String password, String imageUrl) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/singup.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': name, 'email': email,  'image_url': imageUrl, 'password': password, })
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == "success") {
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.email = jsonResponse['message']['email'];
      this.imageUrl = jsonResponse['message']['image_url'];
      this.password = jsonResponse['message']['password'];
    }

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> updateName(String name) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/update_name.php"),
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
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/update_password.php"),
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

  Future <BackendMessage> addHotel(String name, String price, String location, String about, String imageUrl) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_hotel.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'user_id': id, 'name': name, 'price': price, 'location': location, 'about': about, 'image_url': imageUrl})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addCity(String name, String location, String about, String imageUrl) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_city.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'user_id': id, 'name': name, 'location': location, 'about': about, 'image_url': imageUrl})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addTimeline(String title, String body, String imageUrl) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_timeline.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'user_id': id, 'title': title, 'body': body, 'image_url': imageUrl})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <dynamic> getCreatedHotels() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/user_hotels.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCreatedCities() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/user_cities.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCreatedTimelines() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/user_timelines.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <dynamic> getAllHotels() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/all_hotels.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getAllCities() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/all_cities.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getAllTimelines() async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/all_timelines.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <BackendMessage> addHotelReview(String hotelId, String review) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addCityReview(String cityId, String review) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'city_id': cityId, 'hotel_id': null, "timeline_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addTimelineReview(String timelineId, String review) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_review.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'timeline_id': timelineId,'hotel_id': null, "city_id": null, 'user_id': this.id, 'review': review})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> addHotelLike(String hotelId, double like) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addCityLike(String cityId, double like) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'city_id': cityId, 'hotel_id': null, "timeline_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> addTimelineLike(String timelineId, double like) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/add_like.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'timeline_id': timelineId, 'hotel_id': null, "city_id": null, 'user_id': this.id, 'like': like.toString()})
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <dynamic> getHotelReviews(String hotelId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/hotel_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': hotelId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getCityReviews(String cityId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/city_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'city_id': cityId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
  Future <dynamic> getTimelineReviews(String timelineId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/timeline_reviews.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'timeline_id': timelineId})
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }

  Future <BackendMessage> deleteHotel(String hotelId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': hotelId, "city_id": null, "timeline_id": null, })
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> deleteCity(String cityId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': null, "city_id": cityId, "timeline_id": null, })
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
  Future <BackendMessage> deleteTimeline(String timelineId) async {
    Response response = await post( Uri.parse("https://travelingapp2.000webhostapp.com/delete_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'hotel_id': null, "city_id": null, "timeline_id": timelineId, })
    );
    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
}

class BackendMessage {
  String status = '';
  String message = '';

  BackendMessage(this.status, this.message);
}

class NotificationMessage {
  String title = '';
  String body = '';
  dynamic payload;

  NotificationMessage(this.title, this.body, this.payload);
}