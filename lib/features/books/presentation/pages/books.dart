import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagwa_task/core/extensions/spaces.dart';
import 'package:nagwa_task/core/shared_widgets/app_error_widget.dart';
import 'package:nagwa_task/core/shared_widgets/app_loading.dart';
import 'package:nagwa_task/core/theme/adaptive_layout_widget.dart';
import 'package:nagwa_task/core/theme/colors.dart';
import 'package:nagwa_task/features/books/presentation/cubit/books_cubit.dart';
import 'package:nagwa_task/features/books/presentation/widgets/books_list_mobile_view.dart';
import 'package:nagwa_task/features/books/presentation/widgets/books_list_tablet_view.dart';
import 'package:nagwa_task/features/books/presentation/widgets/search_field.dart';

class Books extends StatefulWidget {
  const Books({super.key});
  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  late BooksCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<BooksCubit>();
    cubit.fetchBooks();
    cubit.setupScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books Library')),
      body: BlocConsumer<BooksCubit, BooksState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Initial) {
            return AppLoading();
          }
          if (state is BooksLoaded || state is LoadMoreData) {
            return Column(
              children: [
                SearchField(
                  onSubmitted: (value) => cubit.searchBooks(value),
                  onCancel: () => cubit.clearSearch(),
                  controller: cubit.searchController,
                ),
                cubit.currentBooks.isEmpty
                    ? const Center(
                      child: Text(
                        'No Books Found',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.lightGreyBorder,
                        ),
                      ),
                    )
                    : Expanded(
                      child: AdaptiveLayout(
                        mobileLayout:
                            (context) =>
                                BooksListMobileView(books: cubit.currentBooks),
                        tabletLayout:
                            (context) =>
                                BooksListTabletView(books: cubit.currentBooks),
                      ),
                    ),
                if (state is LoadMoreData)
                  AppLoading(
                    isLarge: false,
                  ).withMargin(const EdgeInsets.all(20)),
              ],
            ).withPadding(const EdgeInsets.all(15));
          }
          if (state is Error) {
            return AppErrorWidget(
              errorType: state.type,
              errorMessage: state.message,
              onPressed: state.onRetry,
            ).withPadding(const EdgeInsets.all(15));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLoading(isLarge: true),
              heightSpace(20),
              AppLoading(),
            ],
          );
        },
      ),
    );
  }
}
