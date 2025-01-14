// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_pruned.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePruned _$ImagePrunedFromJson(Map<String, dynamic> json) => ImagePruned(
      imagesDeleted: (json['ImagesDeleted'] as List<dynamic>)
          .map((e) => ImageRemoved.fromJson(e as Map<String, dynamic>))
          .toList(),
      spaceReclaimed: (json['SpaceReclaimed'] as num).toInt(),
    );

Map<String, dynamic> _$ImagePrunedToJson(ImagePruned instance) =>
    <String, dynamic>{
      'ImagesDeleted': instance.imagesDeleted,
      'SpaceReclaimed': instance.spaceReclaimed,
    };
