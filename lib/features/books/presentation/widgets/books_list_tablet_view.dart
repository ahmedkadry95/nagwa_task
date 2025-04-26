// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nagwa_task/core/extensions/spaces.dart';
import 'package:nagwa_task/core/shared_widgets/app_loading.dart';
import 'package:nagwa_task/core/theme/colors.dart';
import 'package:nagwa_task/core/theme/styles.dart';
import 'package:nagwa_task/features/books/domain/entities/book.dart';
import 'package:nagwa_task/features/books/presentation/cubit/books_cubit.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class BooksListTabletView extends StatelessWidget {
  late List<BookEntity> books;
  BooksListTabletView({super.key, required this.books});
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      controller: context.read<BooksCubit>().scrollController,
      itemCount: books.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder:
          (context, index) => Card(
            color: AppColors.white,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: context.width,
                  imageUrl: books[index].formats.jpeg!,
                  placeholder: (context, url) => AppLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                heightSpace(20),
                RichText(
                  text: TextSpan(
                    text:
                        books[index].authors.length == 1
                            ? 'Author: '
                            : 'Authors: ',
                    style: AppTextStyles.headline1(
                      context,
                    ).copyWith(color: AppColors.primary),
                    children: <TextSpan>[
                      ...books[index].authors.map(
                        (author) => TextSpan(
                          text: author.name,
                          style: AppTextStyles.headline1(context),
                        ),
                      ),
                    ],
                  ),
                ).withMargin(const EdgeInsets.symmetric(horizontal: 15)),
                heightSpace(20),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: ReadMoreText(
                    books[index].summary,
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                    colorClickableText: Colors.red,
                    trimCollapsedText: 'See More',
                    trimExpandedText: 'See less',
                    style: AppTextStyles.headline1(context),
                  ),
                ).withMargin(const EdgeInsets.symmetric(horizontal: 15)),
                heightSpace(20),
              ],
            ),
          ),
    );
  }
}
