import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    required this.source,
    required this.news,
  });

  Source source;
  List<NewsElement> news;

  factory News.fromJson(Map<String, dynamic> json) => News(
    source: Source.fromJson(json["Source"]),
    news: List<NewsElement>.from(
        json["News"].map((x) => NewsElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Source": source.toJson(),
    "News": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class NewsElement {
  NewsElement({
    required this.title,
    required this.time,
    required this.url,
    required this.content,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.imageDescription,
  });

  String title;
  String time;
  String url;
  String content;
  String imageUrl;
  String description;
  String category;
  String imageDescription;

  factory NewsElement.fromJson(Map<String, dynamic> json) => NewsElement(
    title: json["title"],
    time: json["time"],
    url: json["url"],
    content: json["content"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    category: json["category"],
    imageDescription: json["imageDescription"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "time": time,
    "url": url,
    "content": content,
    "description": description,
    "imageUrl": imageUrl,
    "category": category,
    "imageDescription": imageDescription,
  };
}

class Source {
  Source({
    required this.name,
    required this.url,
    required this.dteCreatin,
    required this.category,
  });

  String name;
  String url;
  String dteCreatin;
  String category;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    name: json["name"],
    url: json["URL"],
    dteCreatin: json["dteCreatin"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "URL": url,
    "dteCreatin": dteCreatin,
    "category": category,
  };
}
