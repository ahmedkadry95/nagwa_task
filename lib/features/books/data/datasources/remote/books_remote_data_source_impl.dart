import 'package:nagwa_task/features/books/data/datasources/remote/books_remote_data_source.dart';
import 'package:nagwa_task/features/books/data/models/book_page_dto.dart';

import '../../../../../core/network/network_helper.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final NetworkHelper networkHelper;

  UserRemoteDataSourceImpl(this.networkHelper);

  @override
  Future<BookPageDto> getBooks({String searchQuery = ''}) async {
    final data = await networkHelper.get(
      '/books',
      query:
          searchQuery.isNotEmpty
              ? {'search': Uri.encodeQueryComponent(searchQuery)}
              : null,
    );
    return BookPageDto.fromJson(data);
  }

  @override
  Future<BookPageDto> loadMoreBooks({required String url}) async {
    final data = await networkHelper.getUri(url);
    return BookPageDto.fromJson(data);
  }
}
