import 'package:hyll_test_task/model/content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adventure.g.dart';

@JsonSerializable()
class Adventure {
  Adventure({
    required this.title,
    required this.contents,
    this.shortDescription,
  });

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'primary_description', includeIfNull: false)
  final String? shortDescription;
  final List<Content> contents;
  static const fromJson = _$AdventureFromJson;

  Map<String, dynamic> toJson() => _$AdventureToJson(this);
}
