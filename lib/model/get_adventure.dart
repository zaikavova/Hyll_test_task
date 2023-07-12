import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:hyll_test_task/data/travel_service.dart';
import 'package:hyll_test_task/model/adventure.dart';

class GetAdventure {
  GetAdventure(this._travelService);

  final TravelService _travelService;

  Future<List<Adventure>> call(
      {required int offset, required int limit}) async {
    final response =
        await _travelService.getAdventures(limit: limit, offset: offset);

    final bodyCopy = response.body?.data;

    if (bodyCopy != null) {
      return bodyCopy;
    } else {
      throw Exception('Something went wrong!');
    }
  }
}
