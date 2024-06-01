import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neocities/file.dart';
import 'package:neocities/info.dart';
import 'package:neocities/response.dart';

class FailedRequest implements Exception {
  final Response _response;
  FailedRequest(this._response);
  ErrorType get errorRequest => _response.errorType!;
  String get message => _response.message!;
}

class UploadFile {
  String filename;
  int size;
  Stream<List<int>> bytes;
  UploadFile(this.filename, this.size, this.bytes);
}

class Neocities {
  String? username;
  String? password;
  String? apiKey;
  Map<String, String> options;

  Neocities({
    this.username,
    this.password,
    this.apiKey,
    this.options = const {},
  });

  String get url => 'neocities.org';

  Uri _makeUri(String method, [Map<String, dynamic>? params]) {
    var authority = url;
    if (username != null && password != null && apiKey == null) {
      authority = '$username:$password@$url';
    }
    return Uri.https(authority, 'api/$method', params);
  }

  Future<Response> _makeRequest(
    String method, {
    Map<String, dynamic>? params,
    Object? body,
  }) async {
    final uri = _makeUri(method, params);
    final headers = apiKey == null ? null : {'authorization': 'Bearer $apiKey'};

    final httpResponse = body == null
        ? await http.get(uri, headers: headers)
        : await http.post(uri, headers: headers, body: body);

    final response = Response.fromJson(jsonDecode(httpResponse.body));
    if (response.result != Result.success) {
      throw FailedRequest(response);
    }

    return response;
  }

  /// Request info for a neocities site (does not require authentication)
  Future<Info> info(String? siteName) async {
    final response = await _makeRequest(
      'info',
      params: siteName != null ? {'sitename': siteName} : null,
    );
    return response.info!;
  }

  Future<List<File>> list(String? path) async {
    final response = await _makeRequest(
      'list',
      params: path != null ? {'path': path} : null,
    );
    return response.files!;
  }

  Future<String> key() async {
    final response = await _makeRequest('key');
    return response.apiKey!;
  }

  Future<void> delete(List<String> filenames) {
    return _makeRequest('delete', body: {'filenames[]': filenames});
  }

  Future<void> upload(List<UploadFile> files) async {
    final request = http.MultipartRequest('post', _makeUri('upload'));
    if (apiKey != null) {
      request.headers['authorization'] = 'Bearer $apiKey';
    }
    for (final file in files) {
      request.files.add(
        http.MultipartFile(
          file.filename,
          file.bytes,
          file.size,
          filename: file.filename,
        ),
      );
    }

    final streamedResponse = await request.send();
    await streamedResponse.stream.drain();
  }
}
