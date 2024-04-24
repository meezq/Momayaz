class Ads {
  String? _id;
  String? _image;
  String? _url;

  Ads(
    this._id,
    this._image,
    this._url,
  );

  Ads.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _image = map['image'];
    _url = map['url'];
  }

  String get url => _url ?? '';

  set url(String value) {
    _url = value;
  }

  String get image => _image ?? '';

  set image(String value) {
    _image = value;
  }

  String get id => _id ?? '';

  set id(String value) {
    _id = value;
  }
}
