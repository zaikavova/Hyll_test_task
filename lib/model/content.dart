import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  Content({required this.type, required this.resourceUrl});

  @JsonKey(
    name: 'content_type',
    required: true,
    disallowNullValue: true,
    unknownEnumValue: ContentType.unknown,
  )
  final ContentType type;
  @JsonKey(name: 'content_url')
  final String resourceUrl;
  static const fromJson = _$ContentFromJson;

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonEnum(alwaysCreate: true, valueField: 'unknown')
enum ContentType {
  @JsonValue('IMAGE')
  image,
  @JsonValue('VIDEO')
  video,
  @JsonValue('unknown')
  unknown,
}
