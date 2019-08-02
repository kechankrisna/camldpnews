class Post {
  final int id;
  final String date;
  final String title;
  final String excerpt;
  final String content;
  
  final String thumbnail;
  final String image;
  final String type;
  final String link;
  final List categories;

  final String authorName;
  final String authorUrl;
  final String authorDescription;
  final String authorAvatar;

  Post({
    this.id,
    this.date,
    this.title,
    this.excerpt,
    this.content,
    this.thumbnail,
    this.image,
    this.type,
    this.link,
    this.categories,
    this.authorName,
    this.authorDescription,
    this.authorUrl,
    this.authorAvatar,
  });

  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     id: json['id'],
  //     date: json['date'],
  //     title: json['title'],
  //     excerpt: json['excerpt'],
  //     content: json['content'],
  //     image: json['image'],
  //   );
  // }

}
