class BookEntity {
  final int id;
  final String title;
  final List<AuthorEntity> authors;
  final String summary;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final FormatsEntity formats;
  final int downloadCount;

  BookEntity({
    required this.id,
    required this.title,
    required this.authors,
    required this.summary,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });
}
class AuthorEntity {
  final String name;
  final int? birthYear;
  final int? deathYear;

  AuthorEntity({
    required this.name,
    this.birthYear,
    this.deathYear,
  });
}

class FormatsEntity {
  final String? textHtml;
  final String? epub;
  final String? mobi;
  final String? plainText;
  final String? jpeg;

  FormatsEntity({
    this.textHtml,
    this.epub,
    this.mobi,
    this.plainText,
    this.jpeg,
  });
}