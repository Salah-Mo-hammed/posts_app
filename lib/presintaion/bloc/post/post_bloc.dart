import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/domain/usecases/add_post_usecase.dart';
import 'package:ca_post_app/domain/usecases/delete_post_usecase.dart';
import 'package:ca_post_app/domain/usecases/get_all_posts_usecase.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_event.dart';
import 'package:ca_post_app/presintaion/bloc/post/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUsecase getAllPostsUsecase;
  final AddPostUsecase addPostUsecase;
  final DeletePostUsecase deletePosUsecase;

  PostBloc({
    required this.deletePosUsecase,
    required this.addPostUsecase,
    required this.getAllPostsUsecase,
  }) : super(const PostStateLoading()) {
    on<GetAllPostsEvent>(onGetPosts);
    on<AddPostEvent>(onAddPostEvent);
    on<DeletePostEvent>(onDeletePostEvent);
  }

  FutureOr<void> onGetPosts(
      GetAllPostsEvent event, Emitter<PostState> emit) async {
    // ignore: void_checks
    final dataState = await getAllPostsUsecase.call({});
    if (dataState is DataSuccess) {
      emit(PostStateDone(dataState.data!));
    } else if (dataState is DataFaild) {
      emit(PostStateExceptions(dataState.error!));
    }
  }

  FutureOr<void> onAddPostEvent(
      AddPostEvent event, Emitter<PostState> emit) async {
    final dataState = await addPostUsecase.call(event.post);
    if (dataState is DataSuccess) {
      emit(PostStateAddSuccessful(newPost: event.post));
      add(GetAllPostsEvent());
    } else if (dataState is DataFaild) {
      emit(PostStateExceptions(dataState.error!));
    }
  }

  FutureOr<void> onDeletePostEvent(
      DeletePostEvent event, Emitter<PostState> emit) async {
    final dataState = await deletePosUsecase.call(event.postId);
    if (dataState is DataSuccess) {
      emit(PostStateDeleteSuccessful(postId: event.postId));
      add(GetAllPostsEvent());
    } else if (dataState is DataFaild) {
      emit(PostStateExceptions(dataState.error!));
    }
  }
}
