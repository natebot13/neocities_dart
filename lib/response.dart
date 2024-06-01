import 'package:json_annotation/json_annotation.dart';
import 'package:neocities/file.dart';
import 'package:neocities/info.dart';
import 'package:neocities/src/serialization.dart';

part 'response.g.dart';

@jsonEnum
enum ErrorType {
  siteNotFound,
  invalidAuth,
  missingFilenames,
  missingFiles,
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
