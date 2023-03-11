// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:symonic_app/Model/parameter.dart';

class DioHelper {
  late final Dio _dio;

  DioHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.36.6/symonic_app/api',
      ),
    );
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Either<String, List<ParameterData>>> getAllParameters() async {
    try {
      var response = await _dio.get('/parameter');
      var listParameterData = List<ParameterData>.from(
          response.data.map((e) => ParameterData.fromJson(e)));
      return Right(listParameterData);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> addParameter(ParameterData parameterData) async {
    try {
      await _dio.post(
        '/parameter',
        data: parameterData.toJson(),
      );
      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> editParameter(
      ParameterData parameterData) async {
    try {
      await _dio.put(
        '/parameter?id=${parameterData.id}',
        data: parameterData.toJson(),
      );
      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> deleteParameter(int id) async {
    try {
      await _dio.delete(
        '/parameter?id=$id',
      );
      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }
}
