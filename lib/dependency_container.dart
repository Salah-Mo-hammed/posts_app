import 'package:ca_post_app/data/data_source/remote/api_data_source.dart';
import 'package:ca_post_app/data/repo_impl/repo_impl.dart';
import 'package:ca_post_app/domain/repo/repo.dart';
import 'package:ca_post_app/domain/usecases/add_post_usecase.dart';
import 'package:ca_post_app/domain/usecases/delete_post_usecase.dart';
import 'package:ca_post_app/domain/usecases/get_all_posts_usecase.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
//! abstrcat classes connt be instantiated
Future<void> initilaizedDependencies() async {
  //! Dio (singletone)
  sl.registerSingleton<Dio>(Dio());

  //! data-> data sources (singletone)
  sl.registerSingleton<ApiDataSource>(WithDio());

  //! domain-> repo (singletone)
  sl.registerSingleton<Repo>(RepoImpl(apiDataSource: sl<ApiDataSource>()));

  //! domain-> usecases (singletone)
  sl.registerSingleton<GetAllPostsUsecase>(
      GetAllPostsUsecase(repo: sl<Repo>()));

  sl.registerSingleton<AddPostUsecase>(AddPostUsecase(repo: sl<Repo>()));

  sl.registerSingleton<DeletePostUsecase>(DeletePostUsecase(repo: sl<Repo>()));

  //! blocs
  sl.registerFactory<PostBloc>(
    () => PostBloc(
        getAllPostsUsecase: sl<GetAllPostsUsecase>(),
        addPostUsecase: sl<AddPostUsecase>(),
        deletePosUsecase: sl<DeletePostUsecase>()),
  );
}
