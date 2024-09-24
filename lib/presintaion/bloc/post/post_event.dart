import 'package:ca_post_app/domain/entities/post_entity.dart';

abstract class PostEvent {
  const PostEvent();
}

class GetAllPostsEvent extends PostEvent {}

class AddPostEvent extends PostEvent {
  final PostEntity post;
  AddPostEvent({required this.post});
}

class DeletePostEvent extends PostEvent {
  final int postId;
  DeletePostEvent({required this.postId});
}
