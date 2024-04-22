class PartModel {
  String? _dimensions;
  String? _type;

  PartModel(
    this._dimensions,
    this._type,
  );

  String get dimensions => _dimensions ?? "";

  set dimensions(String value) {
    _dimensions = value;
  }

  String get type => _type ?? '';

  set type(String value) {
    _type = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['dimensions'] = dimensions;
    return map;
  }
}
