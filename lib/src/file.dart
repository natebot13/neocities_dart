import 'serialization.dart';

part 'file.g.dart';

@jsonSerializable
class File {
  String path;
  bool isDirectory;
  int? size;
  DateTime updatedAt;
  String? sha1Hash;

  File({
    required this.path,
    required this.isDirectory,
    required this.size,
    required this.updatedAt,
    required this.sha1Hash,
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
  Map<String, dynamic> toJson() => _$FileToJson(this);
}
