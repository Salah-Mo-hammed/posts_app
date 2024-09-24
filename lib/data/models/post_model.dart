import 'package:ca_post_app/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.userId,
      required super.id,
      required super.title,
      required super.body});
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
