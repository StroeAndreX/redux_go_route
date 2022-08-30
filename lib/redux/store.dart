import 'package:redux/redux.dart';
import 'package:redux_go_route/models/app_state.dart';

Store<AppState> store =
    Store<AppState>(appStateReducer, initialState: AppState.initalState());
