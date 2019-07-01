class UserData {

  String _name;
  String _money;
  int _id;
  String _date;
  String _imagepath;

  UserData(this._name,this._money,this._date,this._imagepath);

  UserData.map(dynamic obj){

    this._money =obj['money'];
    this._name =obj['name'];
    this._id =obj['id'];
    this._date=obj['date'];
    this._imagepath=obj['imagepath'];

  }

  int get id =>_id;
  String get name => _name;
  String get money => _money;
  String get date  =>_date;
  String get imagepath => _imagepath;

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if(_id!=null){
      map['id']= _id;
    }
    map['name'] = _name;
    map['money'] = _money;
    map['date'] =_date;
    map['imagepath']=_imagepath;

    return map;
  }

  UserData.fromMap(Map<String, dynamic>map){

    this._id =map['id'];
    this._name=map['name'];
    this._money=map['money'];
    this._date=map['date'];
    this._imagepath=map['imagepath'];
  }

}