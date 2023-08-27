class DataModel {
  Map<String, dynamic>? map;

  DataModel({
    this.map,
  });

  DataModel.fromjson(Map<dynamic, dynamic> json) {
    map = json['map'];
  }

  Map<String, dynamic> tomap() {
    return {
      "map": map,
    };
  }
}
