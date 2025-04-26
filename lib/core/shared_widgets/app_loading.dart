import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nagwa_task/core/theme/colors.dart';

// ignore: must_be_immutable
class AppLoading extends StatelessWidget {
  bool isLarge;
  AppLoading({super.key, this.isLarge = false});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.lightGreyBorder,
        secondRingColor: AppColors.primary,
        thirdRingColor: AppColors.primary,
        size: isLarge ? 65 : 35,
      ),
    );
  }
}
