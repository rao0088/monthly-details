import 'package:flutter/material.dart';
import 'package:monthdetails/pages/AddData.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _password =TextEditingController();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text('Peehu Dairy'),
          centerTitle: true,
          elevation: 3.0,
          leading: Icon(Icons.person_add),
        ),
        body: ListView(
          //reverse: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: Card(
                    elevation: 3.0,
                    child: Image(width: 250, height: 300, fit: BoxFit.fitWidth,
                      image: AssetImage('images/pihu.jpeg',
                      ),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                color: Colors.pink,
                elevation: 3.0,
                onPressed: () {
                  _login(_password.text);
                  // Navigator.pop(context);
                },
                child: Text('Submit', style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            )
          ]//.reversed.toList(),
        )
    );
  }

    _login(String password) {
    if (password.isNotEmpty && password == '2233') {
      _password.clear();
      //showmessgae("password is Right");
      var router =MaterialPageRoute(
          builder: (BuildContext context) => AddData(passd : password));
      Navigator.of(context).push(router);

    } else {
      _password.clear();
      showmessgae("password is wrong or Empty");
    }
  }

  void showmessgae (String alerts) {
    var alert = AlertDialog(
      title: Text('Error Alert'),
      content: Text('Error Alert: $alerts'),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );
  }
}

