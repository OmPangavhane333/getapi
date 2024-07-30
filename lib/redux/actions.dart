// lib/redux/actions.dart
import 'package:user_list_app/models/user.dart';

class FetchUsersAction {
  final List<User> users;

  FetchUsersAction(this.users);
}

class SetSortByAction {
  final String sortBy;

  SetSortByAction(this.sortBy);
}

class SetFilterByAction {
  final String gender;
  final String country;

  SetFilterByAction({required this.gender, required this.country});
}

class IncrementPageAction {}
