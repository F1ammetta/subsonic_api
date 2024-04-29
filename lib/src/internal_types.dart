import 'dart:convert';
import 'subsonicapi_types.dart';

/// A class representing an artist index.
class ArtistIndex {
  final String? name;
  final List<Artist>? artists;

  /// Create an [ArtistIndex] object.
  ArtistIndex({this.artists, this.name});

  /// Create an [ArtistIndex] object from a JSON object.
  factory ArtistIndex.fromJson(Map<String, dynamic> json) {
    List<Artist> artists = [];
    for (var artist in json['artist']) {
      artists.add(Artist(
          id: artist['id'],
          name: utf8.decode(artist['name'].runes.toList()),
          albumCount: artist['albumCount'],
          coverArt: artist['coverArt'],
          artistImageUrl: artist['artistImageUrl']));
    }

    return ArtistIndex(name: json['name'], artists: artists);
  }
}

/// Create a [Song] object from a JSON object.
class Artists {
  final String? ignoredArticles;
  final ArtistIndex? index;

  /// Create an [Artists] object.
  Artists({this.index, this.ignoredArticles});

  /// Create an [Artists] object from a JSON object.
  factory Artists.fromJson(Map<String, dynamic>? json) {
    return json != null
        ? Artists(
            ignoredArticles: json['ignoredArticles'],
            index: ArtistIndex.fromJson(json['index'][0]))
        : Artists();
  }
}

/// A class representing a SubSonic response.
///
/// This class is used to parse the JSON response from the SubSonic server.
/// This class contains all the possible fields that can be returned by the server.
/// Only the fields that are populated by the server will be non-null.
/// The fields are populated based on the type of request made to the server.
///
/// This class is used internally by the SubSonic API client and should not be used directly.
class SubSonicResponse {
  final String status;
  final String version;
  final String type;
  final String serverVersion;
  final Map<String, dynamic>? error;
  final Map<String, dynamic>? errorCode;
  final Map<String, dynamic>? url;
  final Artists? artists;
  final Artist? artist;
  final Map<String, dynamic>? albums;
  final Album? album;
  final Map<String, dynamic>? musicFolders;
  final Map<String, dynamic>? indexes;
  final Map<String, dynamic>? directory;
  final Map<String, dynamic>? json;
  final List<Genre>? genres;
  final License? license;

  /// Create a [SubSonicResponse] object.
  SubSonicResponse({
    required this.status,
    required this.version,
    required this.type,
    required this.serverVersion,
    this.error,
    this.errorCode,
    this.url,
    this.artists,
    this.artist,
    this.albums,
    this.album,
    this.musicFolders,
    this.indexes,
    this.directory,
    this.json,
    this.genres,
    this.license,
  });

  /// Create a [SubSonicResponse] object from a JSON object.
  factory SubSonicResponse.fromJson(Map<String, dynamic> json) {
    json = json['subsonic-response'];
    return SubSonicResponse(
      status: json['status'],
      version: json['version'],
      type: json['type'],
      serverVersion: json['serverVersion'],
      error: json['error'],
      errorCode: json['error-code'],
      url: json['url'],
      artists: Artists.fromJson(json['artists']),
      artist: Artist.fromJson(json['artist']),
      albums: json['albums'],
      album: Album.fromJson(json['album']),
      genres: json['genres'] != null
          ? List<Genre>.from(
              json['genres']['genre'].map((x) => Genre.fromJson(x)))
          : null,
      license: License.fromJson(json['license']),
      musicFolders: json['musicFolders'],
      indexes: json['indexes'],
      directory: json['directory'],
      json: json,
    );
  }
}
