import 'serialization.dart';

part 'info.g.dart';

@jsonSerializable
class Info {
  String sitename;
  int views;
  int hits;
  DateTime createdAt;
  DateTime? lastUpdated;
  String? domain;
  List<String> tags;

  Info({
    required this.sitename,
    this.views = 0,
    this.hits = 0,
    required this.createdAt,
    this.lastUpdated,
    this.domain,
    this.tags = const [],
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
