import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:user_list_app/models/user.dart';
import 'package:user_list_app/redux/actions.dart';
import 'package:user_list_app/redux/reducer.dart';


class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('')),
      
      // for onnecting the widget to the Redux store
      body: StoreConnector<AppState, _ViewModel>(
        // to  converting the store state to the _ViewModel
        converter: (store) => _ViewModel(
          users: store.state.users,
          fetchUsers: () => store.dispatch(FetchUsersAction([])),
          sortBy: store.state.sortBy,
          genderFilter: store.state.genderFilter,
          countryFilter: store.state.countryFilter,
          onSortChange: (sortBy) => store.dispatch(SetSortByAction(sortBy!)),
          onFilterChange: (gender, country) => store.dispatch(SetFilterByAction(gender: gender ?? '', country: country ?? '')),
        ),
        
        // to Build the UI with the converted ViewModel
        builder: (context, viewmodel) {
          return Column(
            children: [
              // here is header section with filters
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Employees', style: TextStyle(fontSize: 40)),
                    Row(
                      children: [
                        // dropdown filter for gender
                        DropdownButton<String>(
                          value: viewmodel.genderFilter.isEmpty ? null : viewmodel.genderFilter,
                          hint: Text('Gender'),
                          items: ['male', 'female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => viewmodel.onFilterChange(value, viewmodel.countryFilter),
                        ),
                        SizedBox(width: 8),
                        
                        // dropdown for country filter
                        DropdownButton<String>(
                          value: viewmodel.countryFilter.isEmpty ? null : viewmodel.countryFilter,
                          hint: Text('Country'),
                          items: ['USA', 'Canada', 'UK'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => viewmodel.onFilterChange(viewmodel.genderFilter, value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Main user table logic
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(150.0),
                      children: [
                        // heading rows of the table
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                            TableCell(child: Center(child: Text('ID'), heightFactor: 2)),
                            TableCell(child: Center(child: Text('Image'), heightFactor: 2)),
                            TableCell(child: Center(child: Text('Full Name'), heightFactor: 2)),
                            TableCell(child: Center(child: Text('Demography'), heightFactor: 2)),
                            TableCell(child: Center(child: Text('Designation'), heightFactor: 2)),
                            TableCell(child: Center(child: Text('Country'), heightFactor: 2)),
                          ],
                        ),
                        
                        // Iterating over the users and creating a row for each user
                        ...viewmodel.users.asMap().entries.map((entry) {
                          int index = entry.key;
                          User user = entry.value;
                          return TableRow(
                            children: [
                              TableCell(child: Center(child: Text('${index + 1}'))),
                              TableCell(
                                child: Center(
                                  child: ClipOval(
                                    child: Image.network(
                                      user.image,
                                      width: 40,
                                      height: 57.6,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(child: Center(child: Text('${user.firstName} ${user.lastName}'))),
                              TableCell(
                                child: Center(
                                  child: Text('${user.gender == 'female' ? 'F' : 'M'}/${user.age}'),
                                ),
                              ),
                              TableCell(child: Center(child: Text(user.designation))),
                              TableCell(child: Center(child: Text(user.country))),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Button to load more users
              ElevatedButton(
                onPressed: viewmodel.fetchUsers,
                child: Text('Load More'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// this is viewModel to map Redux state and actions to the widget
class _ViewModel {
  final List<User> users;
  final void Function() fetchUsers;
  final String sortBy;
  final String genderFilter;
  final String countryFilter;
  final void Function(String?) onSortChange;
  final void Function(String?, String?) onFilterChange;

  _ViewModel({
    required this.users,
    required this.fetchUsers,
    required this.sortBy,
    required this.genderFilter,
    required this.countryFilter,
    required this.onSortChange,
    required this.onFilterChange,
  });
}
