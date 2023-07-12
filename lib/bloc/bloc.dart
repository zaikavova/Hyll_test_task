import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyll_test_task/bloc/state.dart';
import 'package:hyll_test_task/model/adventure.dart';
import 'package:hyll_test_task/model/get_adventure.dart';

class AdventureFeedBloc extends Bloc<_AdventureFeedEvent, AdventureFeedState> {
  AdventureFeedBloc(this._getAdventures)
      : super(AdventureFeedState.initialLoading()) {
    on<_ReloadFeedEvent>(_reloadFeed);
    on<_LoadMoreEvent>(_loadMore);
  }

  final GetAdventure _getAdventures;

  Future<void> _reloadFeed(
      _ReloadFeedEvent _, Emitter<AdventureFeedState> emitter) async {
    final feed = _getFeed();
    if (feed != null) {
      emitter(AdventureFeedState.fetchedLoading(feed));
    } else {
      emitter(AdventureFeedState.initialLoading());
    }

    try {
      final statusUpdate = await _getAdventures.call(offset: 0, limit: 10);

      emitter(
        AdventureFeedState.fetchedIdle(statusUpdate),
      );
    } catch (e) {
      emitter(
        AdventureFeedState.initialError(
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> _loadMore(
      _LoadMoreEvent _, Emitter<AdventureFeedState> emitter) async {
    final feed = _getFeed();
    if (feed == null) {
      throw Exception('Condition exception, refresh bloc first');
    }
    emitter(AdventureFeedState.fetchedLoading(feed));
    try {
      final statusUpdate =
          await _getAdventures.call(offset: feed.length, limit: 10);

      emitter(
        AdventureFeedState.fetchedIdle(
          {...feed, ...statusUpdate}.toList(),
        ),
      );
    } catch (e) {
      emitter(
        AdventureFeedState.fetchedError(
          feed,
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  List<Adventure>? _getFeed() => state.mapOrNull(
      fetchedIdle: (AdventureFeedStateFetchedIdle value) => value.feed,
      fetchedLoading: (AdventureFeedStateFetchedLoading value) => value.feed,
      fetchedError: (AdventureFeedStateFetchedError value) => value.feed);

  void reloadFeed() => add(_ReloadFeedEvent());

  void loadMore() => add(_LoadMoreEvent());
}

abstract class _AdventureFeedEvent {}

class _ReloadFeedEvent implements _AdventureFeedEvent {}

class _LoadMoreEvent implements _AdventureFeedEvent {}
