import 'package:redux/redux.dart';
import 'actions.dart';
import 'package:user_list_app/models/user.dart';

// Class representing the application state
class AppState {
  final List<User> users; 
  final String sortBy; 
  final String genderFilter; 
  final String countryFilter; 
  final int page; 

  // constructor to initialize the state with required fields
  AppState({
    required this.users,
    required this.sortBy,
    required this.genderFilter,
    required this.countryFilter,
    required this.page,
  });

  // Initial state with default values
  AppState.initialState()
      : users = [],
        sortBy = 'id', 
        genderFilter = '', 
        countryFilter = '', 
        page = 0;
}

// Reducer function to manage state updates based on dispatched actions
AppState appReducer(AppState state, dynamic action) {
  // Handling action to fetch users
  if (action is FetchUsersAction) {
    return AppState(
      users: List.from(state.users)..addAll(action.users), // Add fetched users to the existing list
      sortBy: state.sortBy, 
      genderFilter: state.genderFilter, 
      countryFilter: state.countryFilter, 
      page: state.page,
    );
  }
  
  // Handling action to set sorting criteria
  if (action is SetSortByAction) {
    return AppState(
      users: state.users, 
      sortBy: action.sortBy, 
      genderFilter: state.genderFilter, 
      countryFilter: state.countryFilter, 
      page: state.page, 
    );
  }
  
  // Handling action to set filters
  if (action is SetFilterByAction) {
    return AppState(
      users: state.users, 
      sortBy: state.sortBy, 
      genderFilter: action.gender, 
      countryFilter: action.country,
      page: state.page, 
    );
  }
  
  // Handling action to increment the page
  if (action is IncrementPageAction) {
    return AppState(
      users: state.users, 
      sortBy: state.sortBy, 
      genderFilter: state.genderFilter, 
      countryFilter: state.countryFilter, 
      page: state.page + 1, 
    );
  }

  // if no action is matched then return state
  return state;
}
