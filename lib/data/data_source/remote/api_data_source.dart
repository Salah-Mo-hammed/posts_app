import 'package:ca_post_app/core/constants/constants.dart';
import 'package:ca_post_app/core/data_state/data_state.dart';
import 'package:ca_post_app/data/models/post_model.dart';
import 'package:dio/dio.dart';

abstract class ApiDataSource {
  Future<DataState<List<PostModel>>> fetchData();
  Future<DataState<void>> addData(PostModel post);
  Future<DataState<void>> deleteData(int id);
}

class WithDio implements ApiDataSource {
  final Dio dio = Dio();
  @override
  Future<DataState<List<PostModel>>> fetchData() async {
    try {
      Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List data = response.data;
        List<PostModel> posts =
            data.map((jsonPost) => PostModel.fromJson(jsonPost)).toList();
        return DataSuccess(posts);
      } else {
        return DataFaild(DioException(
          response: response,
          message: response.statusMessage,
          requestOptions: response.requestOptions,
        ));
      }
    } catch (e) {
      throw (e as DioException);
    }
  }

  @override
  Future<DataState<void>> addData(PostModel post) async {
    try {
      Response response = await dio.post(baseUrl,
          data: post.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ));
      if (response.statusCode == 201) {
        print("post has been added + ${response.statusCode}");
        return DataSuccess<void>(null);
      } else {
        return DataFaild(
          DioException(
              requestOptions: response.requestOptions,
              response: response,
              message: response.statusMessage,
              type: DioExceptionType.badResponse),
        );
      }
    } catch (e) {
      return DataFaild<void>(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: "$baseUrl/posts"),
        ),
      );
    }
  }

  @override
  Future<DataState<void>> deleteData(int id) async {
    try {
      Response response = await dio.delete("$baseUrl/$id");
      if (response.statusCode == 200) {
        print("post has been deleted + ${response.statusCode}");
        return DataSuccess<void>(null);
      } else {
        return DataFaild(DioException(
            requestOptions: response.requestOptions,
            message: response.statusMessage,
            response: response));
      }
    } catch (e) {
      return DataFaild(DioException(
          error: e, requestOptions: RequestOptions(path: "$baseUrl/$id")));
    }
  }
}
