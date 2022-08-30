import 'package:redux/redux.dart';
import 'package:redux_go_route/models/app_state.dart';
import 'package:redux_go_route/redux/reducers/app_state_reducers.dart';

Store<AppState> store =
    Store<AppState>(appStateReducer, initialState: AppState.initalState());
