import 'image/image.dart';
import 'src/client/http_client.dart';
import 'src/engine/pocker_image.dart';

class Pocker {
  final HttpClient _client;

  Pocker.fromSocket(String socket) : _client = HttpClient(socket: socket);

  ImageApi image() {
    return PockerImage(client: _client);
  }
}
