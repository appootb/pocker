import 'dart:convert';

import 'api_exception.dart';
import 'base_socket.dart';

class HttpClient {
  HttpClient({
    required String socket,
    this.host = 'localhost',
  }) : client = BaseSocket(socket);

  final String host;
  final BaseSocket client;
  final _defaultHeaderMap = <String, String>{};

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  Future<dynamic> getJSON({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp = await client.get(url, headers: headers);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> postJSON({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp =
        await client.post(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> putJSON({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp =
        await client.put(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> patchJSON({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp =
        await client.patch(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> headJSON({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp = await client.head(url, headers: headers);
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }

  Future<dynamic> deleteJSON({
    required String path,
    Map<String, dynamic>? queryParams,
    Object body = const {},
  }) async {
    // TODO auth
    Map<String, String> headers = {};
    headers.addAll(_defaultHeaderMap);
    headers['Content-Type'] = 'application/json';

    final url = Uri.http(host, path, queryParams);
    final resp =
        await client.delete(url, headers: headers, body: json.encode(body));
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw ApiException(
        resp.statusCode,
        utf8.decode(resp.bodyBytes).toString(),
      );
    }
    //
    final respBody = utf8.decode(resp.bodyBytes).toString().trim();
    if (respBody == '') {
      return {};
    }
    return json.decode(respBody);
  }
}
