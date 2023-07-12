import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:hyll_test_task/assembly/json_serializable_converter/serializer.dart';
import 'package:hyll_test_task/bloc/bloc.dart';
import 'package:hyll_test_task/data/travel_service.dart';
import 'package:hyll_test_task/model/adventure.dart';
import 'package:hyll_test_task/model/adventures_response.dart';
import 'package:hyll_test_task/model/content.dart';
import 'package:hyll_test_task/model/get_adventure.dart';

GetIt get _instance => GetIt.instance;

T sl<T extends Object>({
  String? instanceName,
  Object? param1,
  Object? param2,
}) =>
    _instance.call<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );

void init() {
  _instance.registerSingleton<JsonConverter>(
    JsonSerializableConverter({
      Adventure: Adventure.fromJson,
      Content: Content.fromJson,
      AdventuresResponse : AdventuresResponse.fromJson,
    }),
  );
  _instance.registerSingleton<ChopperClient>(
    ChopperClient(converter: sl<JsonConverter>()),
  );
  _instance.registerSingleton<TravelService>(
    TravelService.create(
      _instance<ChopperClient>(),
    ),
  );
  _instance.registerSingleton(
    GetAdventure(
      sl<TravelService>(),
    ),
  );
  _instance.registerFactory<AdventureFeedBloc>(
    () => AdventureFeedBloc(
      sl<GetAdventure>(),
    ),
  );
}
