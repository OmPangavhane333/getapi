import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/reducer.dart';
import 'redux/middleware.dart'; 
import 'features/user_list.dart'; 

void main() {
  // Creating a Redux store with the application state
  final store = Store<AppState>(
    appReducer, // the reducer function that manages state updates
    initialState: AppState.initialState(), // Setting the initial state of the app
    middleware: appMiddleware(), // Applying middleware for handling side effects
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store; // Store instance passed to the widget

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store, // Providing the Redux store to the widget tree
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserList(), //home screen
      ),
    );
  }
}
