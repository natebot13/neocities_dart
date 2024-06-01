// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      result: $enumDecode(_$ResultEnumMap, json['result']),
    )
      ..errorType = $enumDecodeNullable(_$ErrorTypeEnumMap, json['error_type'])
      ..message = json['message'] as String?
      ..info = json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>)
      ..files = (json['files'] as List<dynamic>?)
          ?.map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList()
      ..apiKey = json['api_key'] as String?;

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'result': _$ResultEnumMap[instance.result]!,
      'error_type': _$ErrorTypeEnumMap[instance.errorType],
      'message': instance.message,
      'info': instance.info,
      'files': instance.files,
      'api_key': instance.apiKey,
    };

const _$ResultEnumMap = {
  Result.success: 'success',
  Result.error: 'error',
};

const _$ErrorTypeEnumMap = {
  ErrorType.siteNotFound: 'site_not_found',
  ErrorType.invalidAuth: 'invalid_auth',
  ErrorType.missingFilenames: 'missing_filenames',
  ErrorType.missingFiles: 'missing_files',
};
