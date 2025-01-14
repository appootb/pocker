import 'package:json_annotation/json_annotation.dart';

part 'image_id.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageId {
  ImageId({
    required this.id,
  });

  String id;

  factory ImageId.fromJson(Map<String, dynamic> json) =>
      _$ImageIdFromJson(json);

  Map<String, dynamic> toJson() => _$ImageIdToJson(this);
}
