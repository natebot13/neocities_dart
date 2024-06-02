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
  ErrorType.invalidAuth: 'invalid_auth',
  ErrorType.siteNotFound: 'site_not_found',
  ErrorType.siteNotAllowed: 'site_not_allowed',
  ErrorType.missingFiles: 'missing_files',
  ErrorType.tooLarge: 'too_large',
  ErrorType.tooManyFiles: 'too_many_files',
  ErrorType.invalidFileType: 'invalid_file_type',
  ErrorType.directoryExists: 'directory_exists',
  ErrorType.fileTooLarge: 'file_too_large',
  ErrorType.filePathTooLong: 'file_path_too_long',
  ErrorType.fileNameTooLong: 'file_name_too_long',
  ErrorType.missingArguments: 'missing_arguments',
  ErrorType.badPath: 'bad_path',
  ErrorType.badNewPath: 'bad_new_path',
  ErrorType.missingFile: 'missing_file',
  ErrorType.renameError: 'rename_error',
  ErrorType.missingFilenames: 'missing_filenames',
  ErrorType.badFilename: 'bad_filename',
  ErrorType.cannotDeleteSiteDirectory: 'cannot_delete_site_directory',
  ErrorType.cannotDeleteIndex: 'cannot_delete_index',
  ErrorType.notFound: 'not_found',
};
