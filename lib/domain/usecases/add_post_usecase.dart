import 'package:ca_post_app/core/base_usecase/base_usecase.dart';
import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/domain/entities/post_entity.dart';
import 'package:ca_post_app/domain/repo/repo.dart';

class AddPostUsecase
    extends BaseUseCase<DataState<void>, PostEntity> {
  Repo repo;
  AddPostUsecase({required this.repo});

  @override
  Future<DataState<void>> call( PostEntity params) {
    return repo.addPost(params);
  }
  
 
}
