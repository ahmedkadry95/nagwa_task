import 'package:flutter/material.dart';
import 'package:nagwa_task/core/constants/images.dart';
import 'package:nagwa_task/core/extensions/spaces.dart';
import 'package:nagwa_task/core/network/api_result.dart';
import 'package:nagwa_task/core/shared_widgets/app_button.dart';
import 'package:nagwa_task/core/theme/styles.dart';

// ignore: must_be_immutable
class AppErrorWidget extends StatelessWidget {
  ApiErrorType errorType;
  String errorMessage;
  void Function()? onPressed;

  AppErrorWidget({
    super.key,
    required this.errorType,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                getErrorImage(errorType),
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.fill,
              ),
              heightSpace(20),
              Text(
                errorMessage,
                style: AppTextStyles.headline1(context),
                textAlign: TextAlign.center,
              ),
              heightSpace(20),
              AppLoadingButton(
                onPressed: onPressed,
                isLoading: false,
                text: 'Try Again',
              ),
            ],
          ),
        );
      },
    );
  }
}

getErrorImage(ApiErrorType errorType) {
  switch (errorType) {
    case ApiErrorType.noInternet:
    case ApiErrorType.connectionTimeout:
    case ApiErrorType.sendTimeout:
    case ApiErrorType.receiveTimeout:
    case ApiErrorType.connectionError:
    case ApiErrorType.gatewayTimeout:
      return AppImages.noInternet;
    case ApiErrorType.notFound:
      return AppImages.notFound;
    default:
      return AppImages.unKnown;
  }
}
