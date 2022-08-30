import 'package:redux_go_route/models/auth.dart';

class AppState {
  // user and app content
  final Auth auth;

  /// Constructor
  const AppState({required this.auth});

  /// Initialize the state of the store
  AppState.initalState() : auth = Auth();
}
