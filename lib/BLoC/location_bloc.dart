import 'dart:async';
import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';


class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  // 1 streamController too manage sink / streams ( i.e. inputs / outputs )
  final _locationController = StreamController<Location>();

  // 2  get the stream
  Stream<Location> get locationStream => _locationController.stream;

  // 3 input => sink that will be provided for the stream later
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  // 4 to ensure closing the stream
  @override
  void dispose() {
    _locationController.close();
  }
}