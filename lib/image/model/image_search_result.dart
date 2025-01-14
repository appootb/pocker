import 'package:json_annotation/json_annotation.dart';

part 'image_search_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageSearchResult {
  ImageSearchResult({
    required this.index,
    required this.name,
    required this.description,
    required this.tag,
    required this.official,
    required this.automated,
    required this.stars,
  });

  String index;

  String name;

  String description;

  String tag;

  String official;

  String automated;

  int stars;

  bool isOfficial() {
    return official == '[OK]';
  }

  bool isAutomated() {
    return automated == '[OK]';
  }

  factory ImageSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ImageSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSearchResultToJson(this);
}
