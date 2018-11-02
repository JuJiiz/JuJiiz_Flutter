class EventModel {
  final String key, title, point;

  EventModel({this.key, this.title, this.point});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      key: json['key'] as String,
      title: json['title'] as String,
      point: json['point'] as String,
    );
  }
}
