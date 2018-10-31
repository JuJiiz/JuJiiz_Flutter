class ImageModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ImageModel(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  ImageModel.fromJson(Map<String, dynamic> parseJson) {
    albumId = parseJson['albumId'];
    id = parseJson['id'];
    title = parseJson['title'];
    url = parseJson['url'];
    thumbnailUrl = parseJson['thumbnailUrl'];
  }
}
