
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/customer.dart';
import 'dart:io';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../utils/Buttons.dart';
import '../utils/api.dart';


class ChoseImageScreen extends StatefulWidget {
  final String id;
  final bool isForShop ;
  final bool isForCity ;
  final bool isForTimeline ;

  const ChoseImageScreen({required Key key, required this.id, required this.isForShop, required this.isForCity, required this.isForTimeline}) : super(key: key);
  @override
  ChoseImageScreenState createState() => ChoseImageScreenState();
}

class ChoseImageScreenState extends State<ChoseImageScreen> {
  //
  late CloudApi api;
  late Future<XFile?> file;
  String status = '';
  late String base64Image;
  late File? tmpFile;
  String errMessage = 'Error Uploading Image';

  late File _image;
  late Uint8List _imageBytes;
  late Future future;

  @override
  initState(){
    super.initState();
    api = CloudApi();
  }

  chooseImage() async {
    // XFile? xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    // String? xImagePath = xImage?.path;
    // file = File(xImagePath!) as Future<File?>;
    file = ImagePicker().pickImage(source: ImageSource.gallery);

    String? imagePath;
    setState(() {
      file.then((image) => {
          imagePath = image?.path,
        _image = File(imagePath!),
        _imageBytes = _image.readAsBytesSync(),
        tmpFile = File(imagePath!),
        base64Image = base64Encode(tmpFile?.readAsBytesSync() as List<int>),
      });
    });

  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() async {
    setStatus('Uploading Image...');

    String? fileType = tmpFile?.path.split('.').last;
    var uuid = const Uuid();
    String fileName =  '${uuid.v1()}.$fileType' ;
    final response = await api.save(fileName, _imageBytes);
    if (widget.isForShop) {
      updateShopsImageToBackend(widget.id, response.downloadLink.toString());
    } else if (widget.isForCity) {
      updateCitiesImageToBackend(widget.id, response.downloadLink.toString());
    } else if (widget.isForTimeline) {
      updateTimelinesImageToBackend(widget.id, response.downloadLink.toString());
    } else {
      updateUsersImageToBackend(widget.id, response.downloadLink.toString());
    }
    setStatus('Done...');
    Navigator.pop(context,);
  }

  Widget showImage() {
    return FutureBuilder<XFile?>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<XFile?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && null != snapshot.data) {

          XFile? xFile = snapshot.data!;
          String? xImagePath = xFile?.path;
          tmpFile = File(xImagePath!);
          base64Image = base64Encode(tmpFile?.readAsBytesSync() as List<int>);
          return Flexible(
            child: Image.file(
              snapshot.data as File,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set New Image",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            WideButton.bold('Choose Image', chooseImage, true ),
            const SizedBox(
              height: 20.0,
            ),
            // showImage(),
            const SizedBox(
              height: 20.0,
            ),
            WideButton.bold('Upload Image', startUpload, true ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Future <BackendMessage> updateImageToBackend(String email, String imageURL) async {
    Response response = await post("https://dont-wait.herokuapp.com/image" as Uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'image_url': imageURL}));

    var jsonResponse = jsonDecode(response.body);
    return BackendMessage(jsonResponse['status'], jsonResponse['message']);
  }

  Future <BackendMessage> updateShopsImageToBackend(String id, String imageURL) async {
    Response response = await post(Uri.parse("https://travelingapp.000webhostapp.com/update_hotel_image.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id, 'image_url': imageURL}));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'], jsonResponse['message']);
  }

  Future <BackendMessage> updateCitiesImageToBackend(String id, String imageURL) async {
    Response response = await post(Uri.parse("https://travelingapp.000webhostapp.com/update_city_image.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id, 'image_url': imageURL}));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'], jsonResponse['message']);
  }

  Future <BackendMessage> updateUsersImageToBackend(String id, String imageURL) async {
    Response response = await post(Uri.parse("https://travelingapp.000webhostapp.com/update_user_image.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id, 'image_url': imageURL}));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'], jsonResponse['message']);
  }

  Future <BackendMessage> updateTimelinesImageToBackend(String id, String imageURL) async {
    Response response = await post(Uri.parse("https://travelingapp.000webhostapp.com/update_timeline_image.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'id': id, 'image_url': imageURL}));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'], jsonResponse['message']);
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Sign UP Page',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}