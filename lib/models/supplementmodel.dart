class SupplementModel {
  // String? exercise;
  // String? link;
  Map<String , dynamic> ? map ;

  SupplementModel({
    // this.exercise,
    // this.link,
    this.map ,
  });

  SupplementModel.fromjson(Map<dynamic, dynamic> json) {
    // exercise = json['exercise'];
    // link = json['link'];
    map = json['map'] ;

  }

  Map<String, dynamic> tomap() {
    return {
      // "exercise": exercise,
      // "link": link,
      "map": map,
    };
  }
}