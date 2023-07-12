import 'package:hyll_test_task/model/adventure.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adventures_response.g.dart';

@JsonSerializable()
class AdventuresResponse {
  AdventuresResponse(this.data, this.count, this.next);

  final List<Adventure> data;
  final int count;
  final String next;
  static const fromJson = _$AdventuresResponseFromJson;

  Map<String, dynamic> toJson() => _$AdventuresResponseToJson(this);
}