class ShippingModel {
  String? _shippingType;

  ShippingModel(this._shippingType);

  String get shippingType => _shippingType ?? "";

  set modelName(String value) {
    _shippingType = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = shippingType;
    return map;
  }
}
