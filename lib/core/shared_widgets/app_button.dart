import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nagwa_task/core/extensions/spaces.dart';
import 'package:nagwa_task/core/theme/colors.dart';

import '../theme/styles.dart';

// ignore: must_be_immutable
class AppLoadingButton extends StatelessWidget {
  bool isLoading;
  bool isPrimary;
  void Function()? onPressed;
  String text;

  AppLoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(Size(context.width, 45)),
        elevation: WidgetStateProperty.all<double>(2.5),
        backgroundColor: WidgetStateProperty.all<Color>(
          isPrimary ? AppColors.primary : AppColors.white,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isPrimary ? AppColors.primary : AppColors.lightGreyBorder,
              width: 1,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child:
          isLoading
              ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                  size: 25,
                  color: AppColors.white,
                  secondRingColor: AppColors.lightGreyBorder,
                  thirdRingColor: AppColors.secondary,
                ),
              )
              : Center(
                child: Text(
                  text,
                  style:
                      isPrimary
                          ? AppTextStyles.primaryButton(context)
                          : AppTextStyles.secondaryButton(context),
                ),
              ),
    );
  }
}
