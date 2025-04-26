import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:nagwa_task/core/network/network_helper.dart';
import 'package:nagwa_task/features/books/data/datasources/remote/books_remote_data_source_impl.dart';
import 'package:nagwa_task/features/books/data/repositories/books_repository_impl.dart';
import 'package:nagwa_task/features/books/domain/repositories/books_repository.dart';
import 'package:nagwa_task/features/books/domain/usecases/get_books_usecase.dart';
import 'package:nagwa_task/features/books/domain/usecases/load_more_books_usecase.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

void initSl() {
  // Core

  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://gutendex.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 5),
        validateStatus: (status) => status! < 500,
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 90,
      ),
    );
    return dio;
  });

  sl.registerLazySingleton(() => NetworkHelper(sl()));

  // Data sources
  sl.registerLazySingleton(() => UserRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<BooksRepository>(() => UserRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetBooksUseCase(sl()));
  sl.registerLazySingleton(() => LoadMoreBooksUsecase(sl()));
}
