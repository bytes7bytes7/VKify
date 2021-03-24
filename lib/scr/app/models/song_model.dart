import 'dart:convert';

class Song {
  final String url;
  final String title;
  final String author;
  final int seconds;
  final String songImageUrl;
  bool isAdded;
  bool isDownloaded;
  bool isLiked;

  Song({
    this.url,
    this.title,
    this.author,
    this.seconds,
    this.songImageUrl,
    this.isAdded,
    this.isDownloaded,
    this.isLiked,
  });

  Map<String, dynamic> toMap() {
    return {
      'url':this.url,
      'title': title,
      'author': author,
      'seconds': seconds,
      'songImageUrl': songImageUrl,
      'isAdded': isAdded,
      'isDownloaded': isDownloaded,
      'isLiked': isLiked,
    };
  }

  static Song fromMap(Map<String, dynamic> map) {
    return Song(
      url: map['url'],
      title: map['title'],
      author: map['author'],
      seconds: map['seconds'],
      songImageUrl: map['songImageUrl'],
      isAdded: map['isAdded'],
      isDownloaded: map['isDownloaded'],
      isLiked: map['isLiked'],
    );
  }

  String toJson() => json.encode(toMap());

  static Song fromJson(String str) => fromMap(json.decode(str));
}
