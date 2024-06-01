// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      sitename: json['sitename'] as String,
      views: (json['views'] as num?)?.toInt() ?? 0,
      hits: (json['hits'] as num?)?.toInt() ?? 0,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      lastUpdated: _$JsonConverterFromJson<String, DateTime>(
          json['last_updated'], const DateTimeConverter().fromJson),
      domain: json['domain'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'sitename': instance.sitename,
      'views': instance.views,
      'hits': instance.hits,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'last_updated': _$JsonConverterToJson<String, DateTime>(
          instance.lastUpdated, const DateTimeConverter().toJson),
      'domain': instance.domain,
      'tags': instance.tags,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
