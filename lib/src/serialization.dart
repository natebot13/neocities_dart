import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

final _rfc2822 = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z');

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return _rfc2822.parse(json);
  }

  @override
  String toJson(DateTime date) {
    return _rfc2822.format(date);
  }
}

const jsonSerializable = JsonSerializable(
  fieldRename: FieldRename.snake,
  converters: [DateTimeConverter()],
);

const jsonEnum = JsonEnum(fieldRename: FieldRename.snake);
