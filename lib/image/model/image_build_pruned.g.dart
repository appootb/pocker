// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_build_pruned.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageBuildPruned _$ImageBuildPrunedFromJson(Map<String, dynamic> json) =>
    ImageBuildPruned(
      cachesDeleted: (json['CachesDeleted'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spaceReclaimed: (json['SpaceReclaimed'] as num).toInt(),
    );

Map<String, dynamic> _$ImageBuildPrunedToJson(ImageBuildPruned instance) =>
    <String, dynamic>{
      'CachesDeleted': instance.cachesDeleted,
      'SpaceReclaimed': instance.spaceReclaimed,
    };
