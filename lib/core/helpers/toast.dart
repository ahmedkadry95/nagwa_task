import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToasts {
  static void showErrorToast(String message) {
    toastification.show(
      showProgressBar: true,
      title: Text(message),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.minimal,
    );
  }

  static void showSuccessToast(String message) {
    toastification.show(
      showProgressBar: true,
      title: Text(message),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.minimal,
    );
  }

  static void showInfoToast(String message) {
    toastification.show(
      showProgressBar: true,
      title: Text(message),
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 2),
      style: ToastificationStyle.minimal,
    );
  }

  
}
