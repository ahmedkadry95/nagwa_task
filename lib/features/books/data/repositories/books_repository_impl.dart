import 'package:nagwa_task/features/books/data/datasources/remote/books_remote_data_source_impl.dart';
import 'package:nagwa_task/features/books/data/models/book_page_dto.dart';
import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/books_repository.dart';

class UserRepositoryImpl implements BooksRepository {
  final UserRemoteDataSourceImpl remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<BookPageEntity>> getBooks({String searchQuery = ''}) async {
    try {
      final bookPageDto = await remoteDataSource.getBooks(
        searchQuery: searchQuery,
      );
      return ApiSuccess(bookPageDto.toEntity());
    } catch (e) {
      return ApiFailure(
        ApiErrorHandler.handle(e).message,
        type: ApiErrorHandler.handle(e).type,
      );
    }
  }

  @override
  Future<ApiResult<BookPageEntity>> loadMoreBooks({required String url}) async {
    try {
      final bookPageDto = await remoteDataSource.loadMoreBooks(url: url);
      return ApiSuccess(bookPageDto.toEntity());
    } catch (e) {
      return ApiFailure(
        ApiErrorHandler.handle(e).message,
        type: ApiErrorHandler.handle(e).type,
      );
    }
  }
}
