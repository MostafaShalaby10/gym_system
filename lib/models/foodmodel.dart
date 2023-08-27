class FoodModel {
  // String? exercise;
  // String? link;
  String? day;
  Map<String , dynamic> ? map ;

  FoodModel({
    // this.exercise,
    // this.link,
    this.day,
    this.map ,
  });

  FoodModel.fromjson(Map<dynamic, dynamic> json) {
    // exercise = json['exercise'];
    // link = json['link'];
    day = json['day'];
    map = json['map'] ;

  }

  Map<String, dynamic> tomap() {
    return {
      // "exercise": exercise,
      // "link": link,
      "day": day,
      "map": map,
    };
  }
}