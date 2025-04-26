import 'package:nagwa_task/features/books/domain/entities/book.dart';

class BookPageEntity {
  int totalItems;
  String nextPageUrl;
  String previousPageUrl;
  List<BookEntity> books;

  BookPageEntity({
    required this.totalItems,
    required this.nextPageUrl,
    required this.previousPageUrl,
    required this.books,
  });
}
