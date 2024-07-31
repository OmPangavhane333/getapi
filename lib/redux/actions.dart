import 'package:user_list_app/models/user.dart';

//for fetching users from an API or a data source
class FetchUsersAction {
  final List<User> users; // List to hold the fetched users

  // Constructor for the users list
  FetchUsersAction(this.users);
}

// logic of sorting criteria
class SetSortByAction {
  final String sortBy; 
  
  SetSortByAction(this.sortBy);
}

//for setting the filters applied to the user list
class SetFilterByAction {
  final String gender; 
  final String country; 

  
  SetFilterByAction({required this.gender, required this.country});
}

class IncrementPageAction {}
