import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nagwa_task/core/router/routes_data.dart';
import 'package:nagwa_task/features/books/presentation/cubit/books_cubit.dart';
import 'package:nagwa_task/features/books/presentation/pages/books.dart';

final router = GoRouter(
  initialLocation: RoutesPath.books,
  routes: <RouteBase>[
    GoRoute(
      path: RoutesPath.books,
      builder:
          (context, state) => BlocProvider(
            create: (context) => BooksCubit(),
            child: const Books(),
          ),
    ),
  ],
);
