// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      path: json['path'] as String,
      isDirectory: json['is_directory'] as bool,
      size: (json['size'] as num?)?.toInt(),
      updatedAt:
          const DateTimeConverter().fromJson(json['updated_at'] as String),
      sha1Hash: json['sha1_hash'] as String?,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'path': instance.path,
      'is_directory': instance.isDirectory,
      'size': instance.size,
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
      'sha1_hash': instance.sha1Hash,
    };
