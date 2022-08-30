import 'package:redux/redux.dart';
import 'package:redux_go_route/models/auth.dart';
import 'package:redux_go_route/redux/actions/auth_actions.dart';

Reducer<Auth> authReducers = combineReducers<Auth>([
  TypedReducer<Auth, UpdateAuthState>(updateAuthState),
]);

Auth updateAuthState(Auth state, dynamic action) {
  state.isAuth = true;
  return state;
}
