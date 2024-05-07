class ProductModel {
  String? _title;
  String? _category;
  String? _categoryId;
  String? _price;
  String? _description;
  String? _location;
  String? _date;
  bool? _isLiked;

  String get date => _date ?? "";

  set date(String value) {
    _date = value;
  }

  String? _userName;
  String? _userId;
  String? _productId;
  String? _userImage;

  String get productId => _productId ?? "";

  String get categoryId => _categoryId ?? '';

  set categoryId(String value) {
    _categoryId = value;
  }

  set productId(String value) {
    _productId = value;
  }

  List<dynamic>? _images;

  ///
  String? _vName;
  String? _vModel;
  String? _vColor;
  String? _vType;

  ///
  String? _shippingType;

  ///
  String? _carServiceType;

  String get dimensions => _dimensions ?? "";

  set dimensions(String value) {
    _dimensions = value;
  }

  String? _dimensions;
  String? _partType;

  String get title => _title ?? "";

  set title(String value) {
    _title = value;
  }

  String get category => _category ?? "";

  String get partType => _partType ?? "";

  set partType(String value) {
    _partType = value;
  }

  String get carServiceType => _carServiceType ?? "";

  set carServiceType(String value) {
    _carServiceType = value;
  }

  String get shippingType => _shippingType ?? "";

  set shippingType(String value) {
    _shippingType = value;
  }

  String get vType => _vType ?? "";

  set vType(String value) {
    _vType = value;
  }

  String get vColor => _vColor ?? "";

  set vColor(String value) {
    _vColor = value;
  }

  String get vModel => _vModel ?? "";

  set vModel(String value) {
    _vModel = value;
  }

  String get vName => _vName ?? "";

  set vName(String value) {
    _vName = value;
  }

  List<dynamic> get images => _images ?? [];

  set images(List<dynamic> value) {
    _images = value;
  }

  String get userImage => _userImage ?? "";

  set userImage(String value) {
    _userImage = value;
  }

  String get userId => _userId ?? "";

  set userId(String value) {
    _userId = value;
  }

  String get userName => _userName ?? "";

  set userName(String value) {
    _userName = value;
  }

  String get location => _location ?? "";

  set location(String value) {
    _location = value;
  }

  String get description => _description ?? "";

  set description(String value) {
    _description = value;
  }

  String get price => _price ?? "";

  set price(String value) {
    _price = value;
  }

  set category(String value) {
    _category = value;
  }

  bool get isLiked => _isLiked ?? false;

  set isLiked(bool value) {
    _isLiked = value;
  }

  ProductModel.fromMap(String id, Map<String, dynamic> map) {
    _categoryId = map['categoryId'];
    _title = map['title'];
    _category = map['category'];
    _price = map['price'];
    _description = map['description'];
    _date = map['date'];
    _images = map['images'];
    _location = map['location'];
    _userName = map['userName'];
    _userId = map['userId'];
    _productId = id;
    _userImage = map['userImage'];
    _shippingType = map['type'];
    _carServiceType = map['type'];
    _partType = map['type'];
    _dimensions = map['area'];

    _vName = map['name'];
    _vColor = map['color'];
    _vModel = map['model'];
    _vType = map['type'];
  }

  ProductModel(
    this._productId,
    this._dimensions,
    this._title,
    this._category,
    this._categoryId,
    this._price,
    this._date,
    this._description,
    this._location,
    this._userName,
    this._userId,
    this._userImage,
    this._images,
    this._vName,
    this._vModel,
    this._vColor,
    this._vType,
    this._shippingType,
    this._carServiceType,
    this._partType,
      this._isLiked,
  ) {
    _title = title;
  }
}
