import 'package:json_annotation/json_annotation.dart';

import 'image_removed.dart';

part 'image_pruned.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImagePruned {
  ImagePruned({
    required this.imagesDeleted,
    required this.spaceReclaimed,
  });

  /// Images that were deleted
  List<ImageRemoved> imagesDeleted;

  /// Disk space reclaimed in bytes
  int spaceReclaimed;

  factory ImagePruned.fromJson(Map<String, dynamic> json) =>
      _$ImagePrunedFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePrunedToJson(this);
}
