// lib/redux/reducer.dart
import 'package:redux/redux.dart';
import 'actions.dart';
import 'package:user_list_app/models/user.dart';

class AppState {
  final List<User> users;
  final String sortBy;
  final String genderFilter;
  final String countryFilter;
  final int page;

  AppState({
    required this.users,
    required this.sortBy,
    required this.genderFilter,
    required this.countryFilter,
    required this.page,
  });

  AppState.initialState()
      : users = [],
        sortBy = 'id',
        genderFilter = '',
        countryFilter = '',
        page = 0;
}

AppState appReducer(AppState state, dynamic action) {
  if (action is FetchUsersAction) {
    return AppState(
      users: List.from(state.users)..addAll(action.users),
      sortBy: state.sortBy,
      genderFilter: state.genderFilter,
      countryFilter: state.countryFilter,
      page: state.page,
    );
  }
  if (action is SetSortByAction) {
    return AppState(
      users: state.users,
      sortBy: action.sortBy,
      genderFilter: state.genderFilter,
      countryFilter: state.countryFilter,
      page: state.page,
    );
  }
  if (action is SetFilterByAction) {
    return AppState(
      users: state.users,
      sortBy: state.sortBy,
      genderFilter: action.gender,
      countryFilter: action.country,
      page: state.page,
    );
  }
  if (action is IncrementPageAction) {
    return AppState(
      users: state.users,
      sortBy: state.sortBy,
      genderFilter: state.genderFilter,
      countryFilter: state.countryFilter,
      page: state.page + 1,
    );
  }
  return state;
}
