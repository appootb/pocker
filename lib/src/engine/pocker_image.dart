import 'package:pocker/src/client/http_client.dart';
import 'package:pocker/image/image.dart';
import 'package:pocker/image/model/container_config.dart';
import 'package:pocker/image/model/image_build_pruned.dart';
import 'package:pocker/image/model/image_history.dart';
import 'package:pocker/image/model/image_id.dart';
import 'package:pocker/image/model/image_inspect.dart';
import 'package:pocker/image/model/image_pruned.dart';
import 'package:pocker/image/model/image_removed.dart';
import 'package:pocker/image/model/image_search_result.dart';
import 'package:pocker/image/model/image_summary.dart';
import 'package:pocker/model/filters.dart';
import 'package:pocker/model/label.dart';

class PockerImage implements ImageApi {
  PockerImage({required this.client});

  final HttpClient client;

  @override
  Future<List<ImageSummary>> listImages({
    bool? all = false,
    bool? digests = false,
    bool? dangling,
    String? before,
    String? reference,
    String? since,
    Label? label,
  }) async {
    //
    final filters = Filters();
    if (before != null) {
      filters.add('before', before);
    }
    if (dangling != null) {
      filters.add('dangling', dangling.toString());
    }
    if (label != null) {
      filters.add('label', label.toString());
    }
    if (reference != null) {
      filters.add('reference', reference);
    }
    if (since != null) {
      filters.add('since', since);
    }
    //
    List<dynamic> list = await client.getJSON(
      path: '/images/json',
      queryParams: {
        'all': all.toString(),
        'filters': filters.toString(),
        'digests': digests.toString(),
      },
    );
    return list.map((json) => ImageSummary.fromJson(json)).toList();
  }

  @override
  Future<void> buildImage({
    String dockerfile = 'Dockerfile',
    String? t,
    String? extraHosts,
    String? remote,
  }) async {}

  @override
  Future<ImageBuildPruned> buildPrune({
    int? keepStorage,
    bool? all = false,
    String? until,
    String? id,
    String? parent,
    String? type,
    String? description,
    bool? inuse,
    bool? shared,
    bool? private,
  }) async {
    //
    final filters = Filters();
    if (until != null) {
      filters.add('until', until);
    }
    if (id != null) {
      filters.add('id', id);
    }
    if (parent != null) {
      filters.add('parent', parent);
    }
    if (type != null) {
      filters.add('type', type);
    }
    if (description != null) {
      filters.add('description', description);
    }
    if (inuse != null) {
      filters.add('inuse', inuse.toString());
    }
    if (shared != null) {
      filters.add('shared', shared.toString());
    }
    if (private != null) {
      filters.add('private', private.toString());
    }
    //
    Map<String, dynamic> pruned = await client.postJSON(
      path: '/build/prune',
      queryParams: {
        'keep-storage': keepStorage != null ? keepStorage.toString() : '0',
        'all': all.toString(),
        'filters': filters.toString(),
      },
    );
    return ImageBuildPruned.fromJson(pruned);
  }

  @override
  Future<void> createImage({
    String? fromImage,
    String? fromSrc,
    String? repo,
    String? tag,
    String? message,
    List<String>? changes,
    String? platform,
  }) async {}

  @override
  Future<ImageInspect> inspectImage({required String name}) async {
    Map<String, dynamic> inspect =
        await client.getJSON(path: '/images/$name/json');
    return ImageInspect.fromJson(inspect);
  }

  @override
  Future<List<ImageHistory>> imageHistory({
    required String name,
  }) async {
    List<dynamic> history = await client.getJSON(path: '/images/$name/history');
    return history.map((json) => ImageHistory.fromJson(json)).toList();
  }

  @override
  Future<void> pushImage({
    required String name,
    String? tag,
  }) async {
    await client
        .postJSON(path: '/images/$name/push', queryParams: {'tag': tag ?? ''});
  }

  @override
  Future<void> tagImage({
    required String name,
    required String repo,
    required String tag,
  }) async {
    await client.postJSON(path: '/images/$name/tag', queryParams: {
      'repo': repo,
      'tag': tag,
    });
  }

  @override
  Future<List<ImageRemoved>> removeImage({
    required String name,
    bool? force = false,
    bool? noprune = false,
  }) async {
    List<dynamic> list =
        await client.deleteJSON(path: '/images/$name', queryParams: {
      'force': force.toString(),
      'noprune': noprune.toString(),
    });
    return list.map((json) => ImageRemoved.fromJson(json)).toList();
  }

  @override
  Future<List<ImageSearchResult>> searchImages({
    required String term,
    bool? isOfficial,
    bool? isAutomated,
    int? starCount,
    int? limit,
  }) async {
    //
    final filters = Filters();
    if (isAutomated != null) {
      filters.add('is-automated', isOfficial.toString());
    }
    if (isOfficial != null) {
      filters.add('is-official', isOfficial.toString());
    }
    if (starCount != null) {
      filters.add('stars', starCount.toString());
    }
    //
    List<dynamic> list = await client.getJSON(
      path: '/images/search',
      queryParams: {
        'term': term,
        'limit': limit != null ? limit.toString() : '0',
        'filters': filters.toString(),
      },
    );
    return list.map((json) => ImageSearchResult.fromJson(json)).toList();
  }

  @override
  Future<ImagePruned> pruneImages(
      {bool? dangling, String? until, Label? label}) async {
    //
    final filters = Filters();
    if (dangling != null) {
      filters.add('dangling', dangling.toString());
    }
    if (until != null) {
      filters.add('until', until);
    }
    if (label != null) {
      filters.add('label', label.toString());
    }
    //
    Map<String, dynamic> pruned = await client.postJSON(
      path: '/images/prune',
      queryParams: {
        'filters': filters.toString(),
      },
    );
    return ImagePruned.fromJson(pruned);
  }

  @override
  Future<ImageId> commitImage({
    required String container,
    required String repo,
    required String tag,
    String? comment,
    String? author,
    bool? pause = true,
    String? changes,
    ContainerConfig? containerConfig,
  }) async {
    Map<String, dynamic> imageId = await client.postJSON(
      path: '/commit',
      queryParams: {
        'container': container,
        'repo': repo,
        'tag': tag,
        'comment': comment ?? '',
        'author': author ?? '',
        'pause': pause.toString(),
        'changes': changes ?? '',
      },
      body: containerConfig ?? {},
    );
    return ImageId.fromJson(imageId);
  }

  @override
  Future<void> exportImage({
    required String path,
    required String name,
  }) async {}

  @override
  Future<void> exportImages({
    required String path,
    required String names,
  }) async {}

  @override
  Future<void> loadImages({
    required String path,
    bool? quiet = false,
  }) async {}
}
