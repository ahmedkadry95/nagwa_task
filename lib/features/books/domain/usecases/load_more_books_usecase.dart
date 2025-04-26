import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';

import '../../../../core/network/api_result.dart';

import '../repositories/books_repository.dart';

class LoadMoreBooksUsecase {
  final BooksRepository repository;

  LoadMoreBooksUsecase(this.repository);

  Future<ApiResult<BookPageEntity>> call({required String url}) async {
    return repository.loadMoreBooks(url: url);
  }
}
