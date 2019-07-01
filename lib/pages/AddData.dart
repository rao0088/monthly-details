import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:monthdetails/database/UserData.dart';
import 'package:monthdetails/database/DataHelper.dart';
import 'package:monthdetails/pages/Addmoney.dart';
class AddData extends StatefulWidget {

  final String passd;
  AddData({Key key, this.passd}): super(key : key);
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  Databasehelper dbhelper = Databasehelper();
  final List <UserData> _userlistd =<UserData>[];

  @override
  void initState() {
    super.initState();
    _showdata();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page Show'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var router =MaterialPageRoute(
              builder: (BuildContext context) => AddPage() );
          Navigator.of(context).push(router);
        },
        child: Icon(Icons.add),
      ),
      body:Container(
          child: ListView.builder(
              padding:  const EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _userlistd.length,
              itemBuilder: (_,int index){

                return Card(
                  child: ListTile(
                    leading: Text(" ${_userlistd[index].id}"),
                    title:Text("Name: ${_userlistd[index].name}"),
                    onTap: ()=>_showdataview(_userlistd[index].id),
                    subtitle: Text("Date: ${_userlistd[index].date}"),

                    trailing: GestureDetector(
                      child: Icon(Icons.delete,color: Colors.red,),
                      onTap: () =>_deletealert(_userlistd[index].id, index),
                    ),
                  ),

                );

              }),
        ),
    );
  }
  _showdata() async{
    List items = await dbhelper.gettwoUsers();
    items.forEach((item){

     // UserData userd = UserData.map(item);

      setState(() {

        _userlistd.add(UserData.map(item));


      });

      //print("this title :${userd.name}");
      //debugPrint("$user");

    });


  }

  _delete (int ids, int index) async{

    int id = await dbhelper.deleteUser(ids);

    print("user deleted: $id");

    setState(() {
      _userlistd.removeAt(index);
    });

  }

  _deletealert(int id, int index) {

    var alert = AlertDialog(
      title: Text('Error Alert delete'),
      content: Text('Error Alert: Are You Sure to delete?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
           _delete(id, index);
           Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );
  }

  _showdataview(int id) async {
    UserData map = await dbhelper.getUser(id);
   // map.toMap();
   //print(map.id);
    Uint8List _bytesImage;
    _bytesImage = Base64Decoder().convert(map.imagepath);



    var alert = AlertDialog(
      title: Text('INFORMATION'),
      content:ListView(
        children: <Widget>[
          Text('NAME: ${map.name}'),
          Text('Money: ${map.money}'),
          Text('DATE TIME: ${map.date}'),
          Card(
            elevation: 4.0,
            child:_bytesImage == null
                ? new Text('No image value.')
                :  Image.memory(_bytesImage),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );

  }

}

