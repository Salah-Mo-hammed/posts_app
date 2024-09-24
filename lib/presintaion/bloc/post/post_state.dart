import 'package:ca_post_app/domain/entities/post_entity.dart';
import 'package:dio/dio.dart';

abstract class PostState {
  final List<PostEntity>? posts;
  final DioException? exception;
  final bool? isUpdated;
  final bool? isDeleted;

  const PostState({this.isDeleted, this.isUpdated, this.posts, this.exception});
}

class PostStateLoading extends PostState {
  const PostStateLoading();
}

class PostStateAddSuccessful extends PostState {
  final PostEntity newPost;
  PostStateAddSuccessful({required this.newPost}) : super(isUpdated: true);
}

class PostStateDeleteSuccessful extends PostState {
  final int postId;
  PostStateDeleteSuccessful({required this.postId}) : super(isDeleted: true);
}

class PostStateDone extends PostState {
  final List<PostEntity> postsList;
  const PostStateDone(this.postsList) : super(posts: postsList);
}

class PostStateExceptions extends PostState {
  final DioException dioException;
  const PostStateExceptions(this.dioException) : super(exception: dioException);
}
