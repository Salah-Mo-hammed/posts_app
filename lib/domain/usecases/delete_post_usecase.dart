import 'package:ca_post_app/core/base_usecase/base_usecase.dart';
import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/domain/repo/repo.dart';

class DeletePostUsecase extends BaseUseCase<DataState<void>, int> {
  Repo repo;
  DeletePostUsecase({required this.repo});
  @override
  Future<DataState<void>> call(int params) {
    return repo.deletePost(params);
  }
}
// still put them in dependenceies 
//and make another bloc for add and delete with their states of course
//and the ui 