import 'package:json_annotation/json_annotation.dart';

part 'image_build_pruned.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageBuildPruned {
  ImageBuildPruned({
    required this.cachesDeleted,
    required this.spaceReclaimed,
  });

  /// Array of strings
  List<String> cachesDeleted;

  /// Disk space reclaimed in bytes
  int spaceReclaimed;

  factory ImageBuildPruned.fromJson(Map<String, dynamic> json) =>
      _$ImageBuildPrunedFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBuildPrunedToJson(this);
}
