import 'package:redux/redux.dart';
import 'package:redux_go_route/models/auth.dart';

Reducer<Auth> authUserReducers = combineReducers<Auth>([]);

Auth updateAuthState(Auth state, dynamic action) {
  state.isAuth = true;
  return state;
}
