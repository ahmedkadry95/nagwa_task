import 'package:flutter/material.dart';
import 'package:nagwa_task/core/router/router.dart';
import 'package:nagwa_task/core/services/service_locator/service_locator.dart';
import 'package:nagwa_task/core/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

void main() {
  initSl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Nagwa Task',
        theme: getAppTheme(),
      ),
    );
  }
}
