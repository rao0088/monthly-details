import 'dart:convert';

//import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:monthdetails/database/DataHelper.dart';

//import 'package:path_provider/path_provider.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:monthdetails/database/UserData.dart';

//import 'package:path_provider/path_provider.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  Databasehelper dbhelper = Databasehelper();
  final List <UserData> _userlistd =<UserData>[];
  //Uint8List _bytesImage;
  File _image;
  String base64Image;
  String _images;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300.0, maxHeight: 350);
    //List<int> image2 = await image.readAsBytes();
    List<int> imageBytes = image.readAsBytesSync();
    print(imageBytes);
    base64Image = base64Encode(imageBytes);
    //print('string is');
    //print(base64Image);
    //print("You selected gallery image : " + image.path);

    //_bytesImage = Base64Decoder().convert(base64Image);

    if (image != null) {
      setState(() {
        _image = image;
        _images = base64Image;
        //print("$image");
      });
    }
  }

  void _saveData(name, money, date, imagepath) async {
    _money.clear();
    _name.clear();
    UserData user = UserData(name, money, date, imagepath);
    int svdata = await dbhelper.saveUser(user);
//    UserData svdatas = await dbhelper.getUser(svdata);

    UserData svdatas = await dbhelper.getUser(svdata);

    //print("item saved id: $svdata");

    setState(() {

      _userlistd.insert(0,svdatas);

    });

    print("item saved id: $svdata");
    Navigator.pop(context);
  }

  TextEditingController _money = TextEditingController();
  TextEditingController _name = TextEditingController();
  String formattedDate =
      DateFormat('h:mm a,EEEE d MMMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD Notes',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: _money,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Money',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.camera_enhance),
                iconSize: 120.0,
                onPressed: () {
                  getImage();
                },
              ),
            ),
            Text("date: $formattedDate"),
            Card(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image,
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
              //Text('image path.$_image'),
            ),
            RaisedButton(
              child: Text(
                'ADD',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () {
                if (_money.text != null && _name != null && _image != null) {
                  _saveData(_name.text, _money.text, formattedDate, _images);
                  //print('scusses');
                } else {
                  _alert();
                }
              },
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              color: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  void _alert() {
    var alert = AlertDialog(
      title: Text('Error Alert'),
      content: Text('Error Alert: Please fill all the feild'),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, builder: (_) => alert);
    //showDialog(context: context , child: alert );
  }
}
