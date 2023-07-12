import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hyll_test_task/model/adventure.dart';

part 'state.freezed.dart';

@freezed
class AdventureFeedState with _$AdventureFeedState{
  const factory AdventureFeedState.initialLoading() =
  AdventureFeedStateInitialLoading;

  const factory AdventureFeedState.initialError(String errorMessage) =
  AdventureFeedStateInitialError;

  const factory AdventureFeedState.fetchedIdle(
      List<Adventure> feed,
      ) = AdventureFeedStateFetchedIdle;

  const factory AdventureFeedState.fetchedLoading(
      List<Adventure> feed,
      ) = AdventureFeedStateFetchedLoading;

  const factory AdventureFeedState.fetchedError(
      List<Adventure> feed,
      String errorMessage,
      ) = AdventureFeedStateFetchedError;
}
