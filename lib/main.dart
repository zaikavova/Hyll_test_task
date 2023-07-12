import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyll_test_task/bloc/bloc.dart';
import 'package:hyll_test_task/bloc/state.dart';
import 'package:hyll_test_task/presentation/screen/feed/initial_error_state.dart';
import 'package:hyll_test_task/presentation/screen/feed/initial_loading_state.dart';

import 'injection_container.dart' as di;
import 'presentation/screen/feed/loaded_status_state.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FeedPage(),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final AdventureFeedBloc _bloc = di.sl<AdventureFeedBloc>();
  late Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _bloc.reloadFeed();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adventures'),
      ),
      body: BlocConsumer<AdventureFeedBloc, AdventureFeedState>(
        bloc: _bloc,
        listener: _blocListener,
        builder: (BuildContext context, AdventureFeedState state) {
          return state.map<Widget>(
            initialLoading: (_) => InitialLoadingStateWidget(),
            initialError: (AdventureFeedStateInitialError state) =>
                InitialErrorStateWidget(
              onRetryPressed: _bloc.reloadFeed,
              errorMessage: state.errorMessage,
            ),
            fetchedIdle: (AdventureFeedStateFetchedIdle state) =>
                LoadedStatusStateWidget(
              adventure: state.feed,
              refresh: _reload,
              loadMore: _bloc.loadMore,
            ),
            fetchedLoading: (AdventureFeedStateFetchedLoading state) =>
                LoadedStatusStateWidget(
              adventure: state.feed,
              refresh: _reload,
            ),
            fetchedError: (AdventureFeedStateFetchedError state) =>
                LoadedStatusStateWidget(
              adventure: state.feed,
              refresh: _reload,
            ),
          );
        },
      ),
    );
  }

  void _blocListener(BuildContext _, AdventureFeedState state) {
    state.whenOrNull<void>(
        fetchedIdle: (_) => _completeRefresh(state),
        fetchedError: (_, __) => _completeRefresh(state));
    final error = state.mapOrNull(fetchedError: (state) => state.errorMessage);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    }
  }

  Future<void> _reload() {
    _bloc.reloadFeed();
    return _refreshCompleter.future;
  }

  void _completeRefresh(AdventureFeedState state) {
    _refreshCompleter.complete();
    _refreshCompleter = Completer<void>();
  }
}
