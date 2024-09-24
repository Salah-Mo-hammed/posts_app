import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/data/data_source/remote/api_data_source.dart';
import 'package:ca_post_app/data/models/post_model.dart';
import 'package:ca_post_app/domain/entities/post_entity.dart';
import 'package:ca_post_app/domain/repo/repo.dart';

class RepoImpl implements Repo {
  ApiDataSource apiDataSource;
  RepoImpl({required this.apiDataSource});
  @override
  Future<DataState<List<PostModel>>> getAllPosts() async {
    return await apiDataSource.fetchData();
  }

  @override
  Future<DataState<void>> addPost(PostEntity postEntity) async {
    final PostModel postModel = PostModel(
        userId: postEntity.userId,
        id: postEntity.id,
        title: postEntity.title,
        body: postEntity.body);
    return await apiDataSource.addData(postModel);
  }

  @override
  Future<DataState<void>> deletePost(int postId) async {
    return await apiDataSource.deleteData(postId);
  }
}
