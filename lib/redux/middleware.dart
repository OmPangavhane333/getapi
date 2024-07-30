import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'actions.dart';
import 'reducer.dart';
import 'package:user_list_app/models/user.dart';

List<Middleware<AppState>> appMiddleware() {
  return [
    TypedMiddleware<AppState, FetchUsersAction>(_fetchUsers),
  ];
}

void _fetchUsers(Store<AppState> store, FetchUsersAction action, NextDispatcher next) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/users?limit=10&skip=${store.state.page * 10}'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final List<User> users = (data['users'] as List)
        .map((json) => User.fromJson(json))
        .where((user) {
          bool matchesGender = store.state.genderFilter.isEmpty || user.gender == store.state.genderFilter;
          bool matchesCountry = store.state.countryFilter.isEmpty || user.country == store.state.countryFilter;
          return matchesGender && matchesCountry;
        })
        .toList();

    if (store.state.sortBy == 'name') {
      users.sort((a, b) => a.firstName.compareTo(b.firstName));
    } else if (store.state.sortBy == 'age') {
      users.sort((a, b) => a.age.compareTo(b.age));
    } else if (store.state.sortBy == 'gender') {
      users.sort((a, b) => a.gender.compareTo(b.gender));
    }

    store.dispatch(FetchUsersAction(users));
  }

  next(action);
}
