import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';

import '../../../../core/network/api_result.dart';

abstract class BooksRepository {
  Future<ApiResult<BookPageEntity>> getBooks({String searchQuery = ''});
  Future<ApiResult<BookPageEntity>> loadMoreBooks({required String url});
}
