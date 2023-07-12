import 'package:chopper/chopper.dart';
import 'package:hyll_test_task/model/adventures_response.dart';

part 'travel_service.chopper.dart';

@ChopperApi(baseUrl: 'https://api.hyll.com/api')
abstract class TravelService extends ChopperService {
  static TravelService create(
    ChopperClient client,
  ) =>
      _$TravelService(client);

  @Get(path: 'adventures/')
  Future<Response<AdventuresResponse>> getAdventures({
    @Query('limit') required int limit,
    @Query('offset') required int offset,
  });
}
