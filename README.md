A simple REST wrapper for the Neocities API.

Example:

```dart
import 'package:neocities/neocities.dart'

void main() async {
  final client = Neocities();

  final info = await client.info('example');
  print(info.toJson())
  client.close();
}
```