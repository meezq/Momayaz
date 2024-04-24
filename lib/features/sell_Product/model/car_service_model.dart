
class CarServiceModel{
  String? _carServiceType;


  CarServiceModel(this._carServiceType);

  String get carServiceType => _carServiceType ?? "";

  set carServiceType(String value) {
    _carServiceType = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = carServiceType;
    return map;
  }
}