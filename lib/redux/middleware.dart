import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'actions.dart'; 
import 'reducer.dart'; 
import 'package:user_list_app/models/user.dart'; 

// this function returns a list of middleware
List<Middleware<AppState>> appMiddleware() {
  return [
    TypedMiddleware<AppState, FetchUsersAction>(_fetchUsers),
  ];
}

// this is middleware function to handle fetching users from the API
void _fetchUsers(Store<AppState> store, FetchUsersAction action, NextDispatcher next) async {
  // for sending a GET request to the API with pagination based on the current page
  final response = await http.get(
    Uri.parse('https://dummyjson.com/users?limit=10&skip=${store.state.page * 10}'),
  );

  // Checking if the response is successful =status code 200
  if (response.statusCode == 200) {
    // decoding the JSON response body
    final data = json.decode(response.body);

    // mapping the received JSON data to User objects
    final List<User> users = (data['users'] as List)
        .map((json) => User.fromJson(json)) 
        .where((user) {
































































































































          // Filtering users based on the gender and country set in the state
          bool matchesGender = store.state.genderFilter.isEmpty || user.gender == store.state.genderFilter;
          bool matchesCountry = store.state.countryFilter.isEmpty || user.country == store.state.countryFilter;
          return matchesGender && matchesCountry; // Returning only users that match the filters
        })
        .toList(); // Converting the filtered list back to a List<User>

    // Dispatching the action to update the store with the fetched users
    store.dispatch(FetchUsersAction(users));
  }

  // Passing the action to the next middleware in the chain
  next(action);
}
