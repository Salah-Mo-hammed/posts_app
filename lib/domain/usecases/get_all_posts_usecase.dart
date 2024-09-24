import 'package:ca_post_app/core/base_usecase/base_usecase.dart';
import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/domain/entities/post_entity.dart';
import 'package:ca_post_app/domain/repo/repo.dart';

class GetAllPostsUsecase
    implements BaseUseCase<DataState<List<PostEntity>>, void> {
  Repo repo;
  GetAllPostsUsecase({required this.repo});
  @override
  Future<DataState<List<PostEntity>>> call(void voids) {
    return repo.getAllPosts();
  }
}
