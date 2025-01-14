// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSummary _$ImageSummaryFromJson(Map<String, dynamic> json) => ImageSummary(
      id: json['Id'] as String,
      parentId: json['ParentId'] as String,
      repoTags:
          (json['RepoTags'] as List<dynamic>).map((e) => e as String).toList(),
      repoDigests: (json['RepoDigests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      created: (json['Created'] as num).toInt(),
      size: (json['Size'] as num).toInt(),
      sharedSize: (json['SharedSize'] as num).toInt(),
      virtualSize: (json['VirtualSize'] as num).toInt(),
      labels: (json['Labels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      containers: (json['Containers'] as num).toInt(),
    );

Map<String, dynamic> _$ImageSummaryToJson(ImageSummary instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ParentId': instance.parentId,
      'RepoTags': instance.repoTags,
      'RepoDigests': instance.repoDigests,
      'Created': instance.created,
      'Size': instance.size,
      'SharedSize': instance.sharedSize,
      'VirtualSize': instance.virtualSize,
      'Labels': instance.labels,
      'Containers': instance.containers,
    };
