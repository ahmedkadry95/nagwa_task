import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nagwa_task/core/helpers/toast.dart';
import 'package:nagwa_task/core/network/api_result.dart';
import 'package:nagwa_task/core/services/service_locator/service_locator.dart';
import 'package:nagwa_task/features/books/domain/entities/book.dart';
import 'package:nagwa_task/features/books/domain/entities/book_page_entity.dart';
import 'package:nagwa_task/features/books/domain/usecases/get_books_usecase.dart';
import 'package:nagwa_task/features/books/domain/usecases/load_more_books_usecase.dart';

part 'books_state.dart';

enum BooksViewType { allBooks, searchResults }

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(Initial());

  final GetBooksUseCase getBooksUseCase = sl<GetBooksUseCase>();
  final LoadMoreBooksUsecase loadMoreBooksUsecase = sl<LoadMoreBooksUsecase>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  late BookPageEntity bookPage;
  late BookPageEntity searchResult;

  BooksViewType viewType = BooksViewType.allBooks;
  String currentSearchQuery = '';

  List<BookEntity> get currentBooks {
    return viewType == BooksViewType.searchResults
        ? searchResult.books
        : bookPage.books;
  }

  String get currentNextPageUrl {
    return viewType == BooksViewType.searchResults
        ? searchResult.nextPageUrl
        : bookPage.nextPageUrl;
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        checkForMoreBooks();
      }
    });
  }

  // ------------------- Fetch All Books -------------------
  void fetchBooks() async {
    emit(Initial());
    viewType = BooksViewType.allBooks;
    currentSearchQuery = '';
    var response = await getBooksUseCase();
    switch (response) {
      case ApiSuccess(data: final data):
        bookPage = data;
        emit(BooksLoaded(bookPageEntity: bookPage));
        break;

      case ApiFailure(:final message, :final type):
        AppToasts.showErrorToast(message);
        emit(Error(onRetry: fetchBooks, message: message, type: type));
        break;
    }
  }

  // ------------------- Search Books -------------------
  void searchBooks(String query) async {
    emit(Initial());
    viewType = BooksViewType.searchResults;
    currentSearchQuery = query.trim();
    var response = await getBooksUseCase(searchQuery: currentSearchQuery);
    switch (response) {
      case ApiSuccess(data: final data):
        searchResult = data;
        emit(BooksLoaded(bookPageEntity: searchResult));
        break;
      case ApiFailure(:final message, :final type):
        AppToasts.showErrorToast(message);
        emit(Error(onRetry: fetchBooks, message: message, type: type));
        break;
    }
  }

  // ------------------- Load More Books -------------------
  void loadMoreBooks() async {
    state is Error
        ? emit(Initial())
        : emit(LoadMoreData()); // this is to reset the state if it was an error

    var response = await loadMoreBooksUsecase(url: currentNextPageUrl);
    switch (response) {
      case ApiSuccess(data: final data):
        if (viewType == BooksViewType.searchResults) {
          searchResult.books.addAll(data.books);
          searchResult.nextPageUrl = data.nextPageUrl;
          emit(BooksLoaded(bookPageEntity: searchResult));
        } else {
          bookPage.books.addAll(data.books);
          bookPage.nextPageUrl = data.nextPageUrl;
          emit(BooksLoaded(bookPageEntity: bookPage));
        }
        break;

      case ApiFailure(:final message, :final type):
        AppToasts.showErrorToast(message);
        emit(Error(onRetry: fetchBooks, message: message, type: type));
        break;
    }
  }

  // ------------------- Check for More books -------------------
  void checkForMoreBooks() {
    if (currentNextPageUrl.isNotEmpty) {
      loadMoreBooks();
    } else {
      AppToasts.showInfoToast('No more books');
    }
  }

  // ------------------- Clear Search -------------------
  void clearSearch() {
    if (viewType == BooksViewType.searchResults) {
      viewType = BooksViewType.allBooks;
      searchController.clear();
      emit(BooksLoaded(bookPageEntity: bookPage));
    }
  }
}
