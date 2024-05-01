class CarModel{

  String? _id;
  String? _image;
  String? _name;

  CarModel(this._id, this._image, this._name);

  String get name => _name ?? "";

  String get image => _image ?? "";

  String get id => _id ?? "";

  CarModel.fromMap(Map<String,dynamic> json)
  {
    _id =  json['id'];
    _image = json['image'];
    _name = json['name'];

  }
}