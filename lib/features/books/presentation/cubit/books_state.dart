part of 'books_cubit.dart';

@immutable
sealed class BooksState {}

final class Initial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksLoaded extends BooksState {
  final BookPageEntity bookPageEntity;

  BooksLoaded({required this.bookPageEntity});
}

final class LoadMoreData extends BooksState {}

// ignore: must_be_immutable
final class Error extends BooksState {
  String message;
  ApiErrorType type;
  VoidCallback? onRetry;
  Error({required this.onRetry, required this.message, required this.type});
}
