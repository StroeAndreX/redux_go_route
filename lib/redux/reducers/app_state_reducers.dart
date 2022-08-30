import 'package:redux_go_route/models/app_state.dart';
import 'package:redux_go_route/redux/reducers/auth_reducers.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    auth: authReducers(state.auth, action),
  );
}
