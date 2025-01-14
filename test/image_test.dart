import 'package:pocker/model/label.dart';
import 'package:pocker/src/client/api_exception.dart';
import 'package:pocker/src/client/http_client.dart';
import 'package:pocker/src/engine/pocker_image.dart';
import 'package:test/test.dart';

void main() {
  final socket = '/var/run/docker.sock';
  HttpClient client = HttpClient(socket: socket);

  group('A group of image tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('List image', () async {
      final engine = PockerImage(client: client);
      // List
      var list = await engine.listImages();
      expect(list.isNotEmpty, isTrue);
      // List with digests
      // list = await engine.listImages(digests: true);
      // expect(list.isNotEmpty, isTrue);
      //
      // list = await engine.listImages(dangling: true);
      // expect(list.isNotEmpty, isTrue);
      // Label
      list = await engine.listImages(label: Label.withLabelKey('maintainer'));
      expect(list.isNotEmpty, isTrue);
    });

    test('Build prune', () async {
      final engine = PockerImage(client: client);
      final pruned = await engine.buildPrune();
      print(pruned);
    });

    test('Create image', () async {});

    test('Inspect image', () async {
      const imgId = 'dba92e6b6488';
      final engine = PockerImage(client: client);
      final info = await engine.inspectImage(name: imgId);
      print(info);
    });

    test('Image history', () async {
      const imgId = 'dba92e6b6488';
      final engine = PockerImage(client: client);
      final list = await engine.imageHistory(name: imgId);
      expect(list.isNotEmpty, isTrue);
    });

    test('Push image', () async {});

    test('Tag image', () async {
      const imgId = 'dba92e6b6488';
      const repo = 'appootb.dev/pocker/test';
      const tag = 'new_tag';
      //
      final engine = PockerImage(client: client);
      await engine.tagImage(name: imgId, repo: repo, tag: tag);
      //
      final info = await engine.inspectImage(name: '$repo:$tag');
      // info.id: 'sha256:xxx'
      final match = RegExp(imgId).matchAsPrefix(info.id, 7);
      expect(match, isNotNull);
    });

    test('Remove image', () async {
      const repo = 'appootb.dev/pocker/test';
      const tag = 'new_tag';
      //
      final engine = PockerImage(client: client);
      await engine.removeImage(name: '$repo:$tag');
      //
      try {
        await engine.inspectImage(name: '$repo:$tag');
      } on ApiException catch (error) {
        if (error.code != 404) {
          throw ApiException(error.code, error.message);
        }
      }
    });

    test('Search images', () async {
      final engine = PockerImage(client: client);
      // Default size: 25
      var list = await engine.searchImages(term: 'nginx');
      expect(list.length == 25, isTrue);
      // Limit
      list = await engine.searchImages(term: 'nginx', limit: 7);
      expect(list.length == 7, isTrue);
      // Official
      list = await engine.searchImages(term: 'nginx', isOfficial: true);
      expect(list.length == 1, isTrue);
      // Automated
      list = await engine.searchImages(term: 'nginx', isAutomated: true);
      expect(list.length == 1, isTrue);
      // Stars
      list = await engine.searchImages(term: 'nginx', starCount: 100);
      expect(list.length < 25 && list.isNotEmpty, isTrue);
    });

    test('Prune images', () async {});

    test('Commit image', () async {});

    test('Export image', () async {});

    test('Export images', () async {});

    test('Load images', () async {});
  });
}
