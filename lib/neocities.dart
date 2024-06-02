import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neocities/src/file.dart';
import 'package:neocities/src/info.dart';
import 'package:neocities/src/response.dart';
import 'package:quiver/collection.dart';

export 'package:neocities/src/file.dart';
export 'package:neocities/src/info.dart';
export 'package:neocities/src/response.dart';

class FailedRequest implements Exception {
  final Response _response;
  FailedRequest(this._response);
  ErrorType get errorRequest => _response.errorType!;
  String get message => _response.message!;
}

class UploadFile {
  String filename;
  int size;
  Stream<List<int>> byteStream;
  UploadFile(this.filename, this.size, this.byteStream);
}

class Neocities {
  http.Client _client;
  String? username;
  String? password;
  String? apiKey;
  Map<String, String> options;

  Neocities({
    this.username,
    this.password,
    this.apiKey,
    this.options = const {},
  }) : _client = http.Client();

  String get url => options['url'] ?? 'neocities.org';

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
    Multimap<String, String>? formData,
  }) async {
    final uri = _makeUri(method, params);
    final request = http.Request(formData == null ? 'get' : 'post', uri);
    request.headers.addAll({
      if (apiKey != null) 'authorization': 'Bearer $apiKey',
      if (formData != null) 'Content-Type': 'application/x-www-form-urlencoded'
    });
    if (formData != null) {
      final dumb = <String>[];
      formData.forEach((k, v) => dumb.add('$k=$v'));
      request.body = dumb.join('&');
    }

    final streamedResponse = await _client.send(request);
    final body = await streamedResponse.stream.transform(utf8.decoder).join();

    final response = Response.fromJson(jsonDecode(body));
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

  Future<String> delete(List<String> filenames) async {
    final map = Multimap<String, String>();
    for (var f in filenames) {
      map.add('filenames[]', f);
    }
    final response = await _makeRequest('delete', formData: map);
    return response.message ?? 'Successfully deleted $filenames';
  }

  Future<String> upload(List<UploadFile> files) async {
    final request = http.MultipartRequest('post', _makeUri('upload'));
    if (apiKey != null) {
      request.headers.addAll({
        if (apiKey != null) 'authorization': 'Bearer $apiKey',
      });
    }
    for (final file in files) {
      request.files.add(
        http.MultipartFile(
          file.filename,
          file.byteStream,
          file.size,
          filename: file.filename,
        ),
      );
    }

    final streamedResponse = await _client.send(request);
    final body = await streamedResponse.stream.transform(utf8.decoder).join();
    final response = Response.fromJson(jsonDecode(body));
    if (response.result != Result.success) {
      throw FailedRequest(response);
    }
    return response.message ?? 'success';
  }

  Future<String> rename(String path, String newPath) async {
    final map = Multimap<String, String>();
    map.add('path', path);
    map.add('new_path', newPath);
    final response = await _makeRequest('rename', formData: map);
    return response.message ?? 'Successfully renamed $path to $newPath';
  }

  void close() {
    _client.close();
  }
}
