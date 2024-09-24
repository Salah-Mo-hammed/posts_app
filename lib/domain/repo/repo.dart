import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/domain/entities/post_entity.dart';

abstract class Repo {
  Future<DataState<List<PostEntity>>> getAllPosts();
  Future<DataState<void>> addPost(PostEntity post);
  Future<DataState<void>> deletePost(int postId);

}
