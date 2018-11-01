class EventModel {
  String key;
  String title;
  String point;

  EventModel(this.key, this.title, this.point);

  EventModel.fromJson(Map<String, dynamic> parseJson) {
    key = parseJson['key'];
    title = parseJson['title'];
    point = parseJson['point'];
  }
}