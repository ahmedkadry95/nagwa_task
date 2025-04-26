import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';

import '../../../../core/network/api_result.dart';

import '../repositories/books_repository.dart';

class GetBooksUseCase {
  final BooksRepository repository;

  GetBooksUseCase(this.repository);

  Future<ApiResult<BookPageEntity>> call({String searchQuery = ''}) async {
    return repository.getBooks(searchQuery: searchQuery);
  }
}
