class FoodReplacementModel {

  String? food1;
  String? food2;

  FoodReplacementModel({
    this.food1,
    this.food2,

  });

  FoodReplacementModel.fromjson(Map<dynamic, dynamic> json) {

    food1 = json['food1'];
    food2 = json['food2'];
  }

  Map<String, dynamic> tomap() {
    return {
      "food1": food1,
      "food2": food2,

    };
  }
}
