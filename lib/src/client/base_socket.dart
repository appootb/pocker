import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class BaseSocket extends http.BaseClient {
  final String socket;
  final HttpClient _inner;

  BaseSocket(this.socket) : _inner = HttpClient() {
    _inner.connectionFactory = ((uri, proxyHost, proxyPort) {
      final host = InternetAddress(socket, type: InternetAddressType.unix);
      return Socket.startConnect(host, 0);
    });
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final HttpClientRequest req =
        await _inner.openUrl(request.method, request.url);
    req.persistentConnection = false;
    req.followRedirects = request.followRedirects;

    request.headers.forEach((name, value) {
      req.headers.add(name, value);
    });
    if (request is http.Request) {
      req.add(utf8.encode(request.body));
    } else {
      throw UnsupportedError('Bad request');
    }

    final HttpClientResponse resp = await req.close();
    final List<int> respBody = await resp
        .fold<List<int>>([], (previous, element) => previous..addAll(element));
    final headers = <String, String>{};
    resp.headers.forEach((name, values) {
      headers[name] = values.join(',');
    });

    return http.StreamedResponse(
      Stream.value(Uint8List.fromList(respBody)),
      resp.statusCode,
      headers: headers,
      contentLength: resp.contentLength == -1 ? null : resp.contentLength,
      isRedirect: resp.isRedirect,
      persistentConnection: resp.persistentConnection,
      reasonPhrase: resp.reasonPhrase,
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
