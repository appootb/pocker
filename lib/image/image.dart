import 'package:pocker/model/label.dart';

import 'model/container_config.dart';
import 'model/image_build_pruned.dart';
import 'model/image_history.dart';
import 'model/image_id.dart';
import 'model/image_inspect.dart';
import 'model/image_pruned.dart';
import 'model/image_removed.dart';
import 'model/image_search_result.dart';
import 'model/image_summary.dart';

// Images
abstract class ImageApi {
  /// List Images
  ///
  /// Returns a list of images on the server. Note that it uses a different,
  /// smaller representation of an image than inspecting a single image.
  ///
  /// Parameters:
  ///
  /// * [bool] all:
  ///   Show all images. Only images from a final layer (no children) are shown by default.
  ///
  /// * [bool] digests:
  ///   Show digest information as a RepoDigests field on each image.
  ///
  /// * [bool] dangling:
  ///
  /// * [String] before:
  ///
  /// * [String] reference:
  ///
  /// * [String] since:
  ///
  /// * [Label] label:
  Future<List<ImageSummary>> listImages({
    bool? all = false,
    bool? digests = false,
    bool? dangling,
    String? before,
    String? reference,
    String? since,
    Label? label,
  });

  /// Build an image
  ///
  /// Build an image from a tar archive with a Dockerfile in it.
  ///
  /// The Dockerfile specifies how the image is built from the tar archive.
  /// It is typically in the archive's root, but can be at a different path
  /// or have a different name by specifying the dockerfile parameter.
  ///
  /// The Docker daemon performs a preliminary validation of the Dockerfile
  /// before starting the build, and returns an error if the syntax is incorrect.
  /// After that, each instruction is run one-by-one until the ID of the new image is output.
  ///
  /// The build is canceled if the client drops the connection by quitting or being killed.
  ///
  /// Parameters:
  ///
  /// * [String] dockerfile:
  ///   Path within the build context to the Dockerfile. This is ignored if
  ///   remote is specified and points to an external Dockerfile.
  ///
  /// * [String] t
  ///   A name and optional tag to apply to the image in the name:tag format.
  ///   If you omit the tag the default latest value is assumed.
  ///   You can provide several t parameters.
  ///
  /// * [String] extraHosts
  ///   Extra hosts to add to /etc/hosts
  ///
  /// * [String] remote
  ///   A Git repository URI or HTTP/HTTPS context URI. If the URI points to
  ///   a single text file, the file’s contents are placed into a file
  ///   called Dockerfile and the image is built from that file.
  ///   If the URI points to a tarball, the file is downloaded by the daemon
  ///   and the contents therein used as the context for the build.
  ///   If the URI points to a tarball and the dockerfile parameter is also
  ///   specified, there must be a file with the corresponding path inside the tarball.
  Future<void> buildImage({
    String dockerfile = 'Dockerfile',
    String? t,
    String? extraHosts,
    String? remote,
  });

  /// Delete builder cache
  ///
  /// Parameters:
  ///
  /// * [int] keepStorage:
  ///   Amount of disk space in bytes to keep for cache
  ///
  /// * [bool] all:
  ///   Remove all types of build cache
  ///
  /// * [String] until:
  ///   Duration relative to daemon's time, during which build cache was not used,
  ///   in Go's duration format (e.g., '24h')
  ///
  /// * [String] id:
  ///
  /// * [String] parent:
  ///
  /// * [String] type:
  ///
  /// * [String] description:
  ///
  /// * [bool] inuse:
  ///
  /// * [bool] shared:
  ///
  /// * [bool] private:
  Future<ImageBuildPruned> buildPrune({
    int? keepStorage,
    bool? all,
    String? until,
    String? id,
    String? parent,
    String? type,
    String? description,
    bool? inuse,
    bool? shared,
    bool? private,
  });

  /// Create an image
  ///
  /// Create an image by either pulling it from a registry or importing it.
  ///
  /// Parameters:
  ///
  /// * [String] fromImage:
  ///   Name of the image to pull. The name may include a tag or digest.
  ///   This parameter may only be used when pulling an image.
  ///   The pull is cancelled if the HTTP connection is closed.
  ///
  /// * [String] fromSrc:
  ///   Source to import. The value may be a URL from which the image
  ///   can be retrieved or - to read the image from the request body.
  ///   This parameter may only be used when importing an image.
  ///
  /// * [String] repo:
  ///   Repository name given to an image when it is imported. The repo may
  ///   include a tag. This parameter may only be used when importing an image.
  ///
  /// * [String] tag:
  ///   Tag or digest. If empty when pulling an image, this causes all tags
  ///   for the given image to be pulled.
  ///
  /// * [String] message:
  ///   Set commit message for imported image.
  ///
  /// * [List<String>] changes:
  ///   Apply Dockerfile instructions to the image that is created,
  ///   for example: changes=ENV DEBUG=true.
  ///   Note that ENV DEBUG=true should be URI component encoded.
  ///   Supported Dockerfile instructions: CMD|ENTRYPOINT|ENV|EXPOSE|ONBUILD|USER|VOLUME|WORKDIR
  ///
  /// * [String] platform:
  ///   Platform in the format os[/arch[/variant]]
  Future<void> createImage({
    String? fromImage,
    String? fromSrc,
    String? repo,
    String? tag,
    String? message,
    List<String>? changes,
    String? platform,
  });

  /// Inspect an image
  ///
  /// Return low-level information about an image.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or id
  Future<ImageInspect> inspectImage({required String name});

  /// Get the history of an image
  ///
  /// Return parent layers of an image.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID
  Future<List<ImageHistory>> imageHistory({
    required String name,
  });

  /// Push an image
  ///
  /// Push an image to a registry.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the image to push. For example, registry.example.com/myimage.
  ///   The image must be present in the local image store with the same name.
  ///
  /// * [String] tag:
  ///   Tag of the image to push. For example, latest. If no tag is provided,
  ///   all tags of the given image that are present in the local image store are pushed.
  Future<void> pushImage({
    required String name,
    String? tag,
  });

  /// Tag an image
  ///
  /// Tag an image so that it becomes part of a repository.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID to tag.
  ///
  /// * [String] repo:
  ///   The repository to tag in. For example, `someuser/someimage`.
  ///
  /// * [String] tag:
  ///   The name of the new tag.
  Future<void> tagImage({
    required String name,
    required String repo,
    required String tag,
  });

  /// Remove an image
  ///
  /// Remove an image, along with any untagged parent images that were referenced by that image.
  /// Images can't be removed if they have descendant images, are being used by a running container or are being used by a build.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID
  ///
  /// * [bool] force:
  ///   Remove the image even if it is being used by stopped containers or has other tags
  ///
  /// * [bool] noprune:
  ///   Do not delete untagged parent images
  Future<List<ImageRemoved>> removeImage({
    required String name,
    bool? force = false,
    bool? noprune = false,
  });

  /// Search images
  ///
  /// Search for an image on Docker Hub.
  ///
  /// Parameters:
  ///
  /// * [String] term:
  ///   Term to search
  ///
  /// * [bool] isOfficial:
  ///
  /// * [bool] isAutomated:
  ///
  /// * [int] starCount:
  ///   Matches images that has at least 'starCount' stars.
  ///
  /// * [int] limit:
  ///   Maximum number of results to return
  Future<List<ImageSearchResult>> searchImages({
    required String term,
    bool? isOfficial,
    bool? isAutomated,
    int? starCount,
    int? limit,
  });

  /// Delete unused images
  ///
  /// Parameters:
  ///
  /// * [bool] dangling:
  ///   When set to true, prune only unused and untagged images.
  ///   When set to false, all unused images are pruned.
  ///
  /// * [String] until:
  ///   Prune images created before this timestamp. The <timestamp>
  ///   can be Unix timestamps, date formatted timestamps, or Go duration
  ///   strings (e.g. 10m, 1h30m) computed relative to the daemon machine’s time.
  ///
  /// * [Label] label:
  ///   label (label=<key>, label=<key>=<value>, label!=<key>, or
  ///   label!=<key>=<value>) Prune images with (or without,
  ///   in case label!=... is used) the specified labels.
  Future<ImagePruned> pruneImages(
      {bool? dangling, String? until, Label? label});

  /// Create a new image from a container
  ///
  /// Parameters:
  ///
  /// * [String] container:
  ///   The ID or name of the container to commit
  ///
  /// * [String] repo:
  ///   Repository name for the created image
  ///
  /// * [String] tag:
  ///   Tag name for the create image
  ///
  /// * [String] comment:
  ///   Commit message
  ///
  /// * [String] author:
  ///   Author of the image (e.g., John Hannibal Smith <hannibal@a-team.com>)
  ///
  /// * [bool] pause:
  ///   Whether to pause the container before committing
  ///
  /// * [String] changes:
  ///   Dockerfile instructions to apply while committing
  Future<ImageId> commitImage({
    required String container,
    required String repo,
    required String tag,
    String? comment,
    String? author,
    bool? pause = true,
    String? changes,
    ContainerConfig? containerConfig,
  });

  /// Export an image
  ///
  /// Get a tarball containing all images and metadata for a repository.
  ///
  /// Parameters:
  ///
  /// * [String] path:
  ///   Tar archive path containing images
  ///
  /// * [String] name:
  ///   Image name or ID
  ///   * If name is a specific name and tag (e.g. ubuntu:latest), then only
  ///     that image (and its parents) are returned.
  ///   * If name is an image ID, similarly only that image (and its parents)
  ///     are returned, but with the exclusion of the repositories file
  ///     in the tarball, as there were no image names referenced.
  Future<void> exportImage({
    required String path,
    required String name,
  });

  /// Export several images
  ///
  /// Get a tarball containing all images and metadata for several image repositories.
  ///
  /// Parameters:
  ///
  /// * [String] path:
  ///   Tar archive path containing images
  ///
  /// * [String] names:
  ///   Image names to filter by:
  ///   * If it is a specific name and tag (e.g. ubuntu:latest), then only
  ///     that image (and its parents) are returned;
  ///   * If it is an image ID, similarly only that image (and its parents)
  ///     are returned and there would be no names referenced in
  ///     the 'repositories' file for this image ID.
  Future<void> exportImages({
    required String path,
    required String names,
  });

  /// Import images
  ///
  /// Load a set of images and tags into a repository.
  ///
  /// Parameters:
  ///
  /// * [String] path:
  ///   Tar archive path containing images
  ///
  /// * [bool] quiet:
  ///   Suppress progress details during load.
  Future<void> loadImages({
    required String path,
    bool? quiet = false,
  });
}
