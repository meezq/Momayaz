class FavProductModel {
  String? _categoryId;

  String? _productId;

  String get productId => _productId ?? "";

  String get categoryId => _categoryId ?? '';

  set categoryId(String value) {
    _categoryId = value;
  }

  set productId(String value) {
    _productId = value;
  }

  FavProductModel.fromMap(String id, Map<String, dynamic> map) {
    _categoryId = map['categoryId'];
    _productId = id;
  }

  FavProductModel(
    this._productId,
    this._categoryId,
  );
}
