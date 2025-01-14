// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSearchResult _$ImageSearchResultFromJson(Map<String, dynamic> json) =>
    ImageSearchResult(
      index: json['Index'] as String,
      name: json['Name'] as String,
      description: json['Description'] as String,
      tag: json['Tag'] as String,
      official: json['Official'] as String,
      automated: json['Automated'] as String,
      stars: (json['Stars'] as num).toInt(),
    );

Map<String, dynamic> _$ImageSearchResultToJson(ImageSearchResult instance) =>
    <String, dynamic>{
      'Index': instance.index,
      'Name': instance.name,
      'Description': instance.description,
      'Tag': instance.tag,
      'Official': instance.official,
      'Automated': instance.automated,
      'Stars': instance.stars,
    };
