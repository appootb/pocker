import 'package:json_annotation/json_annotation.dart';

part 'image_removed.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageRemoved {
  ImageRemoved({
    this.untagged,
    this.deleted,
  });

  /// The image ID of an image that was untagged
  String? untagged;

  /// The image ID of an image that was deleted
  String? deleted;

  factory ImageRemoved.fromJson(Map<String, dynamic> json) =>
      _$ImageRemovedFromJson(json);

  Map<String, dynamic> toJson() => _$ImageRemovedToJson(this);
}
