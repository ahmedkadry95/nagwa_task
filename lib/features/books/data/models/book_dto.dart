import 'package:nagwa_task/features/books/domain/entities/book.dart';

class BookDto {
  final int? id;
  final String? title;
  final List<AuthorDto>? authors;
  final List<String>? summaries;
  final List<TranslatorDto>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final FormatsDto? formats;
  final int? downloadCount;

  BookDto({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    return BookDto(
      id: json['id'] as int?,
      title: json['title'] as String?,
      authors:
          (json['authors'] as List?)
              ?.map((e) => AuthorDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      summaries: (json['summaries'] as List?)?.cast<String>(),
      translators:
          (json['translators'] as List?)
              ?.map((e) => TranslatorDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      subjects: (json['subjects'] as List?)?.cast<String>() ?? [],
      bookshelves: (json['bookshelves'] as List?)?.cast<String>() ?? [],
      languages: (json['languages'] as List?)?.cast<String>() ?? [],
      copyright: json['copyright'] as bool? ?? false,
      mediaType: json['media_type'] as String?,
      formats:
          json['formats'] != null
              ? FormatsDto.fromJson(json['formats'] as Map<String, dynamic>)
              : null,
      downloadCount: json['download_count'] as int? ?? 0,
    );
  }
}

class AuthorDto {
  final String? name;
  final int? birthYear;
  final int? deathYear;

  AuthorDto({this.name, this.birthYear, this.deathYear});

  factory AuthorDto.fromJson(Map<String, dynamic> json) {
    return AuthorDto(
      name: json['name'] as String?,
      birthYear: json['birth_year'] as int?,
      deathYear: json['death_year'] as int?,
    );
  }
}

class TranslatorDto {
  final String? name;

  TranslatorDto({this.name});

  factory TranslatorDto.fromJson(Map<String, dynamic> json) {
    return TranslatorDto(name: json['name'] as String?);
  }
}

class FormatsDto {
  final String? textHtml;
  final String? epub;
  final String? mobi;
  final String? plainText;
  final String? rdf;
  final String? jpeg;
  final String? zip;

  FormatsDto({
    this.textHtml,
    this.epub,
    this.mobi,
    this.plainText,
    this.rdf,
    this.jpeg,
    this.zip,
  });

  factory FormatsDto.fromJson(Map<String, dynamic> json) {
    return FormatsDto(
      textHtml: json['text/html'] as String?,
      epub: json['application/epub+zip'] as String?,
      mobi: json['application/x-mobipocket-ebook'] as String?,
      plainText: json['text/plain; charset=us-ascii'] as String?,
      rdf: json['application/rdf+xml'] as String?,
      jpeg: json['image/jpeg'] as String?,
      zip: json['application/octet-stream'] as String?,
    );
  }
}

extension BookDtoToEntity on BookDto {
  BookEntity toEntity() {
    return BookEntity(
      id: id ?? 0,
      title: title ?? 'Untitled Book',
      authors: authors?.map((author) => author.toEntity()).toList() ?? [],
      summary: summaries?.firstOrNull ?? 'No summary available',
      subjects: subjects ?? [],
      bookshelves: bookshelves ?? [],
      languages: languages ?? [],
      copyright: copyright ?? false,
      mediaType: mediaType ?? 'N/A',
      formats: formats?.toEntity() ?? FormatsEntity(),
      downloadCount: downloadCount ?? 0,
    );
  }
}

extension AuthorDtoToEntity on AuthorDto {
  AuthorEntity toEntity() {
    return AuthorEntity(
      name: name ?? 'Unknown Author',
      birthYear: birthYear ?? 0,
      deathYear: deathYear ?? 0,
    );
  }
}

extension FormatsDtoToEntity on FormatsDto {
  FormatsEntity toEntity() {
    return FormatsEntity(
      textHtml: textHtml ?? 'N/A',
      epub: epub ?? 'N/A',
      mobi: mobi ?? 'N/A',
      plainText: plainText ?? 'N/A',
      jpeg: jpeg ?? 'N/A',
    );
  }
}
