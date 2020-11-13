import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationScreen extends StatelessWidget{
  final bool isFullScreenDialog;
  LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  LocationQueryBloc _bloc = LocationQueryBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationQueryBloc>(
      bloc: _bloc,
      child: Scaffold(
        appBar: AppBar(title: Text("Where to find a restaurant ?"),),
        body: Column(
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search Restaurant",
                  hintText: "enter a place or name ...",
                  icon: Icon(Icons.location_city)),
              onChanged: (query) => _bloc.submitQuery(query),
              ),
            ),
            Expanded(child: _buildResults(_bloc))
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {

        // 1 get data and observe its state
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Enter a location'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    // 2
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            // 3 select location
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);

            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

}