import 'package:pocker/src/client/http_client.dart';
import 'package:pocker/src/image/model/image_summary.dart';
import 'package:test/test.dart';

void main() {
  final socket = '/var/run/docker.sock';
  HttpClient client = HttpClient(socket: socket);

  group('A group of raw client tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Get images', () async {
      List<dynamic> list = await client.getJSON(path: '/images/json');
      List<ImageSummary> images =
          list.map((json) => ImageSummary.fromJson(json)).toList();
      expect(images.isNotEmpty, isTrue);
    });
  });
}
