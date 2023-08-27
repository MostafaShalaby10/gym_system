class ExerciseModel {
  // String? exercise;
  // String? link;
  String? day;
  Map<String , dynamic> ? map ;

  ExerciseModel({
    // this.exercise,
    // this.link,
    this.day,
    this.map ,
  });

  ExerciseModel.fromjson(Map<dynamic, dynamic> json) {
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