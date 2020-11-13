import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restaurant_screen.dart';

class MainScreen extends StatelessWidget {
  // These widgets will automatically listen for events from the stream.
  // When a new event is received, the builder closure will be executed,
  // updating the widget tree. With StreamBuilder and the BLoC pattern,
  // there is no need to call setState()
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder:(context, snapshot) {
          final location = snapshot.data;
          if(location == null) {
           return  LocationScreen();
          }
         return RestaurantScreen(location: location);
        });
  }

}