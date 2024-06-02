import 'package:json_annotation/json_annotation.dart';

import 'serialization.dart';
import 'file.dart';
import 'info.dart';

part 'response.g.dart';

@jsonEnum
enum ErrorType {
  invalidAuth,
  siteNotFound,
  siteNotAllowed,
  missingFiles,
  tooLarge,
  tooManyFiles,
  invalidFileType,
  directoryExists,
  fileTooLarge,
  filePathTooLong,
  fileNameTooLong,
  missingArguments,
  badPath,
  badNewPath,
  missingFile,
  renameError,
  missingFilenames,
  badFilename,
  cannotDeleteSiteDirectory,
  cannotDeleteIndex,
  notFound,
}

@jsonEnum
enum Result {
  success,
  error,
}

@jsonSerializable
class Response {
  Result result;
  ErrorType? errorType;
  String? message;
  Info? info;
  List<File>? files;
  String? apiKey;

  Response({
    required this.result,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
