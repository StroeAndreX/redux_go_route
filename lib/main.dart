import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:redux/redux.dart';
import 'package:redux_go_route/models/app_state.dart';
import 'package:redux_go_route/redux/actions/auth_actions.dart';
import 'package:redux_go_route/redux/store.dart';
import 'package:redux_go_route/user-interface/home.dart';
import 'package:redux_go_route/user-interface/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueKey<String> _scaffoldKey = const ValueKey<String>('App scaffold');

  late final GoRouter _router = GoRouter(routes: <GoRoute>[
    GoRoute(
      path: '/',
      redirect: (_) => '/login',
    ),
    GoRoute(
        path: '/home',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage<void>(key: state.pageKey, child: const HomePage())),
    GoRoute(
        path: '/login',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage<void>(key: state.pageKey, child: const SignIn())),
  ], redirect: _guard);

  String? _guard(GoRouterState state) {
    final bool signedIn = store.state.auth.isAuth;
    final bool signingIn = state.subloc == '/login';

    // Go to /signin if the user is not signed in
    if (!signedIn && !signingIn) {
      return '/login';
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    else if (signedIn && signingIn) {
      return '/home';
    }

    // no redirect
    return null;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreConnector<AppState, _ViewModel>(
            converter: _ViewModel.fromStore,
            builder: (BuildContext context, _ViewModel viewModel) {
              if (viewModel.isLoggedIn) {
                _router.refresh();
              }
              return MaterialApp.router(
                routeInformationProvider: _router.routeInformationProvider,
                routerDelegate: _router.routerDelegate,
                routeInformationParser: _router.routeInformationParser,
              );
            }));
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

class _ViewModel {
  final bool isLoggedIn;
  final Function onPressedCallback;

  _ViewModel(this.isLoggedIn, this.onPressedCallback);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.auth.isAuth, () {
      store.dispatch(UpdateAuthState());
    });
  }
}
