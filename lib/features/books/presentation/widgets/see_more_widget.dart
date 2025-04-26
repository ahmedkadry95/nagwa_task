import 'package:flutter/material.dart';
import 'package:nagwa_task/core/theme/styles.dart';
import 'package:readmore/readmore.dart';

class SeeMoreWidget extends StatelessWidget {
  const SeeMoreWidget({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: ReadMoreText(
        summary,
        trimMode: TrimMode.Line,
        trimLines: 3,
        colorClickableText: Colors.red,
        trimCollapsedText: 'See More',
        trimExpandedText: 'See less',
        style: AppTextStyles.bodyText2(context),
      ),
    );
  }
}
