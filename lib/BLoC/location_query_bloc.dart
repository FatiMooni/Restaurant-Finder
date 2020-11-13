import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  // 1 get stream
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    // 2 the method accepts a string and uses the ZomatoClient class
    // to fetch locations from the API
    // This uses Dart’s async/await syntax to make the code a bit cleaner
    // The results are then published to the stream ..
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}