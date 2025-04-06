import 'package:action_controller_sample/presentation/screen/apple/screen.dart';
import 'package:action_controller_sample/presentation/screen/banana/screen.dart';
import 'package:action_controller_sample/presentation/screen/home/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) => _goRouter;

final _goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: HomeScreen.path,
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: HomeScreen.path,
      name: HomeScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: AppleScreen.path,
      name: AppleScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AppleScreen(),
        );
      },
    ),
    GoRoute(
      path: BananaScreen.path,
      name: BananaScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const BananaScreen(),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
