import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc.dart';

// 1 This means that the provider can only store BLoC objects.
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2  The of method allows widgets to retrieve the BlocProvider from
  // a descendant in the widget tree with the current build context
  static T of<T extends Bloc>(BuildContext context) {
    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  // 3 get type of T
  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4  a passthrough to the widget’s child.
  // This widget will not render anything.
  @override
  Widget build(BuildContext context) => widget.child;

  // 5 When this widget is removed from the tree,
  //  Flutter will call the dispose method,
  //  which will in turn, close the stream
  @override
  void dispose() {
    // close the stream
    widget.bloc.dispose();

    super.dispose();
  }
}
