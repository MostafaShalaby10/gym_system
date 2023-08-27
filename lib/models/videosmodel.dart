class VideoModel {

  String? name;
  String? link;

  VideoModel({
    this.link,
    this.name,

  });

  VideoModel.fromjson(Map<dynamic, dynamic> json) {

    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "link": link,

    };
  }
}
