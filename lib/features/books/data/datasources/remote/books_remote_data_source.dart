import 'package:nagwa_task/features/books/data/models/book_page_dto.dart';

abstract class UserRemoteDataSource {
  Future<BookPageDto> getBooks({String searchQuery = ''});
  Future<BookPageDto> loadMoreBooks({required String url});
}
