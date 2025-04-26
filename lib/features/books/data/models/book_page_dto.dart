import 'package:nagwa_task/features/books/data/models/book_dto.dart';
import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';

class BookPageDto {
  final int count;
  final String? next;
  final String? previous;
  final List<BookDto> results;

  BookPageDto({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BookPageDto.fromJson(Map<String, dynamic> json) {
    return BookPageDto(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List).map((e) => BookDto.fromJson(e)).toList(),
    );
  }
}

extension BookPageDtoToEntity on BookPageDto {
  BookPageEntity toEntity() {
    return BookPageEntity(
      totalItems: count,
      nextPageUrl: next ?? '',
      previousPageUrl: previous ?? '',
      books: results.map((book) => book.toEntity()).toList(),
    );
  }
}
