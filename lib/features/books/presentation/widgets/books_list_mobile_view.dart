// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagwa_task/core/extensions/spaces.dart';
import 'package:nagwa_task/core/shared_widgets/app_loading.dart';
import 'package:nagwa_task/core/theme/colors.dart';
import 'package:nagwa_task/core/theme/raduis.dart';
import 'package:nagwa_task/core/theme/styles.dart';
import 'package:nagwa_task/features/books/domain/entities/book.dart';
import 'package:nagwa_task/features/books/presentation/cubit/books_cubit.dart';
import 'package:nagwa_task/features/books/presentation/widgets/see_more_widget.dart';

// ignore: must_be_immutable
class BooksListMobileView extends StatelessWidget {
  late List<BookEntity> books;
  BooksListMobileView({super.key, required this.books});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: context.read<BooksCubit>().scrollController,
      itemCount: books.length,
      itemBuilder:
          (context, index) => Container(
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: AppColors.lightPrimary,
              borderRadius: RadiusConstants.large,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: RadiusConstants.large,
                        child: AspectRatio(
                          aspectRatio: .75,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: books[index].formats.jpeg!,
                            placeholder: (context, url) => AppLoading(),
                            errorWidget:
                                (context, url, error) => const Icon(
                                  Icons.error,
                                ).withMargin(const EdgeInsets.all(40)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          books[index].title,
                          style: AppTextStyles.headline3(context),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpace(5),
                            RichText(
                              text: TextSpan(
                                text:
                                    books[index].authors.length == 1
                                        ? 'Author: '
                                        : 'Authors: ',
                                style: AppTextStyles.headline5(
                                  context,
                                ).copyWith(color: AppColors.primary),
                                children: <TextSpan>[
                                  ...books[index].authors.map(
                                    (author) => TextSpan(
                                      text: author.name,
                                      style: AppTextStyles.headline5(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            heightSpace(5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(10),
                SeeMoreWidget(summary: books[index].summary),
              ],
            ),
          ),
    );
  }
}
