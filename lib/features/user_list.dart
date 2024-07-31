// lib/features/user_list.dart
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
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel(
          users: store.state.users,
          fetchUsers: () => store.dispatch(FetchUsersAction([])),
          sortBy: store.state.sortBy,
          genderFilter: store.state.genderFilter,
          countryFilter: store.state.countryFilter,
          onSortChange: (sortBy) => store.dispatch(SetSortByAction(sortBy!)),
          onFilterChange: (gender, country) => store.dispatch(SetFilterByAction(gender: gender ?? '', country: country ?? '')),
        ),
        builder: (context, vm) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Employees', style: TextStyle(fontSize: 40)),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: vm.genderFilter.isEmpty ? null : vm.genderFilter,
                          hint: Text('Gender'),
                          items: ['male', 'female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => vm.onFilterChange(value, vm.countryFilter),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<String>(
                          value: vm.countryFilter.isEmpty ? null : vm.countryFilter,
                          hint: Text('Country'),
                          items: ['USA', 'Canada', 'UK'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => vm.onFilterChange(vm.genderFilter, value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView( // Additional scrollable view for vertical scrolling
                    child: Table(
                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(150.0),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[200],
                          ),
                          children: [
                            TableCell(child: Center(child: Text('ID'),heightFactor: 2,)),
                            TableCell(child: Center(child: Text('Image'),heightFactor: 2,)),
                            TableCell(child: Center(child: Text('Full Name'),heightFactor: 2,)),
                            TableCell(child: Center(child: Text('Demography'),heightFactor: 2,)),
                            TableCell(child: Center(child: Text('Designation'),heightFactor: 2,)),
                            TableCell(child: Center(child: Text('Country'),heightFactor: 2,)),
                          ],
                        ),
                        ...vm.users.asMap().entries.map((entry) {
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
                                      height: 40,
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
              ElevatedButton(
                onPressed: vm.fetchUsers,
                child: Text('Load More'),
              ),
            ],
          );
        },
      ),
    );
  }
}


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
