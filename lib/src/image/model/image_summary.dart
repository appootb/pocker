import 'package:json_annotation/json_annotation.dart';

part 'image_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageSummary {
  ImageSummary({
    required this.id,
    required this.parentId,
    required this.repoTags,
    required this.repoDigests,
    required this.created,
    required this.size,
    required this.sharedSize,
    required this.virtualSize,
    this.labels,
    required this.containers,
  });

  /// ID is the content-addressable ID of an image.
  ///
  /// This identifier is a content-addressable digest calculated from
  /// the image's configuration (which includes the digests of layers used by the image).
  ///
  /// Note that this digest differs from the RepoDigests below,
  /// which holds digests of image manifests that reference the image.
  String id;

  /// ID of the parent image.
  ///
  /// Depending on how the image was created, this field may be empty and is only set
  /// for images that were built/created locally.
  /// This field is empty if the image was pulled from an image registry.
  String parentId;

  /// List of image names/tags in the local image cache that reference this image.
  ///
  /// Multiple image tags can refer to the same image, and this list may be empty if
  /// no tags reference the image, in which case the image is "untagged",
  /// in which case it can still be referenced by its ID.
  List<String> repoTags;

  /// List of content-addressable digests of locally available image manifests
  /// that the image is referenced from. Multiple manifests can refer to the same image.
  ///
  /// These digests are usually only available if the image was either pulled from a registry,
  /// or if the image was pushed to a registry, which is when the manifest is generated
  /// and its digest calculated.
  List<String> repoDigests;

  /// Date and time at which the image was created as
  /// a Unix timestamp (number of seconds sinds EPOCH).
  int created;

  /// Total size of the image including all layers it is composed of.
  int size;

  /// Total size of image layers that are shared between this image and other images.
  /// This size is not calculated by default.
  /// -1 indicates that the value has not been set / calculated.
  int sharedSize;

  /// Total size of the image including all layers it is composed of.
  /// In versions of Docker before v1.10, this field was calculated from the image
  /// itself and all of its parent images. Docker v1.10 and up store images self-contained,
  /// and no longer use a parent-chain, making this field an equivalent of the Size field.
  ///
  /// This field is kept for backward compatibility, but may be removed in a future version of the API.
  int virtualSize;

  /// User-defined key/value metadata.
  Map<String, String>? labels;

  /// Number of containers using this image. Includes both stopped and running containers.
  ///
  /// This size is not calculated by default, and depends on which API endpoint is used.
  /// -1 indicates that the value has not been set / calculated.
  int containers;

  factory ImageSummary.fromJson(Map<String, dynamic> json) =>
      _$ImageSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSummaryToJson(this);
}
