class FavModel{
  String? _id;
  String? _category;

  String get id => _id ?? "";
 
 // set id(String value) {
 //    _id = value;
 //  }
  String get category => _category ?? "";
 
 // set category (String value) {
 //    _category = value;
 //  }
  // FavModel.fromMap(String id, Map<String, dynamic> map) {
  //   _category = map['category'];
  //   _id = map['id'];
  // }
  FavModel.fromMap(Map<String,dynamic> json)
  {
    _category = json['category'];
    _id = json['id'];

  }
  FavModel(
    this._id,
    this._category,
  );
}