import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'subsonicapi_types.dart';
import 'internal_types.dart';
import 'dart:typed_data';

/// Create a salt
///
/// Creates a salt for use in creating a token.
String createSalt() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

/// Create a token
///
/// Creates a token for use in authenticating with the Subsonic server.
String createToken(String password, String salt) {
  return md5.convert(utf8.encode(password + salt)).toString();
}

class SubSonicClient {
  /// The URL of the Subsonic server.
  final String _url;

  /// The username for the Subsonic server.
  final String _username;

  /// The auth token for the Subsonic server.
  final String _token;

  /// The salt for the Subsonic server.
  final String _salt;

  /// The client name.
  final String _clientName;

  /// The client version.
  final String _clientVersion;

  /// The format of the response.
  final String format = 'json';

  SubSonicClient(this._url, this._username, this._token, this._salt,
      this._clientName, this._clientVersion);

  /// Ping the server
  ///
  /// Pings the server to check if it is online.
  /// Returns a [SubSonicResponse] object.
  Future<SubSonicResponse> ping() async {
    print(
        '$_url/rest/ping.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format');
    final response = await http.get(Uri.parse(
        '$_url/rest/ping.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  /// Get license
  ///
  /// Gets the license information for the server.
  /// Returns a [License] object.
  Future<License> getLicense() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getLicense.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.license!;
  }

  // TODO: Add MusicFolders class
  /// Get music folders
  ///
  /// Gets the music folders in the music collection.
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains a [MusicFolders] object.
  Future<SubSonicResponse> getMusicFolders() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getMusicFolders.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  // TODO: Add Indexes class
  /// Get indexes
  ///
  /// Gets the indexes in the music collection.
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains an [Indexes] object.
  Future<SubSonicResponse> getIndexes() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getIndexes.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  // TODO: Add Directory class
  /// Get music directory
  ///
  /// Gets the music directory for a given ID.
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains a [Directory] object.
  Future<SubSonicResponse> getMusicDirectory(int id) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getMusicDirectory.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$id&f=$format'));
    print(response.body);
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  /// Get artists
  ///
  /// Gets all artists in the music collection.
  ///
  /// Returns a [List] of [Artist] objects.
  /// These [Artist] objects do NOT contain the list of [Album] objects.
  Future<List<Artist>> getArtists() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getArtists.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.artists!.index!.artists!;
  }

  /// Get artist
  ///
  /// Gets an artist by ID.
  ///
  /// Returns an [Artist] object.
  /// The [Artist] object contains a list of [Album] objects.
  /// These [Album] objects do NOT contain the list of [Song] objects.
  Future<Artist> getArtist(String artistId) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getArtist.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$artistId&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.artist!;
  }

  /// Get album
  ///
  /// Gets an album by ID.
  ///
  /// Returns an [Album] object.
  /// The [Album] object contains a list of [Song] objects.
  Future<Album> getAlbum(String album) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getAlbum.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$album&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.album!;
  }

  /// Get album list
  ///
  /// Gets a list of albums organized by ID3 tags.
  ///
  /// Returns a [List] of [Album] objects.
  Future<List<Album>> getAlbumList2(AlbumParams params) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getAlbumList2.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&$params&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.albumList!;
  }

  /// Get Genres
  ///
  /// Gets all genres in the music collection.
  ///
  /// Returns a [List] of [Genre] objects.
  Future<List<Genre>> getGenres() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getGenres.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.genres!;
  }

  /// Stream Media
  ///
  /// Streams media from the server.
  ///
  /// Returns a [Stream] of [Uint8List].
  Stream<Uint8List> stream(String id) async* {
    final request = http.StreamedRequest(
        'GET',
        Uri.parse(
            '$_url/rest/stream.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$id&f=$format'));
    unawaited(request.sink.close());
    final response = await request.send();

    await for (var chunk in response.stream) {
      yield Uint8List.fromList(chunk);
    }
  }

  /// Get stream URL
  ///
  /// Gets the stream URL for a given ID.
  ///
  /// Returns a [Uri] containing the stream URL.
  Uri getStreamUrl(String id) {
    return Uri.parse(
        '$_url/rest/stream.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$id&f=$format');
  }

  /// Search 3
  ///
  /// Searches the music collection.
  ///
  /// Returns a [SearchResult] object
  /// The [SearchResult] object contains lists of [Artist], [Album], or [Song] objects.
  /// The type of objects returned depends on the search query and parameters.
  Future<SearchResult> search3(String query, SearchParams params) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/search3.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&query=$query&$params&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.searchResult!;
  }

  /// Get Cover
  ///
  /// Gets the cover for the given id
  /// Returns a [Uint8List] object
  Future<Uint8List> getCover(String id, int size) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getCoverArt.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$id&size=$size&f=$format'));

    return response.bodyBytes;
  }

  /// Get Cover Stream
  ///
  /// Gets the cover for the given id
  /// Returns a [Stream] of [Uint8List] objects
  Stream<Uint8List> getCoverStream(String id, int size) async* {
    final request = http.StreamedRequest(
        'GET',
        Uri.parse(
            '$_url/rest/getCoverArt.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$id&size=$size&f=$format'));
    unawaited(request.sink.close());
    final response = await request.send();

    await for (var chunk in response.stream) {
      yield Uint8List.fromList(chunk);
    }
  }

  /// Get songs
  ///
  /// Gets all songs in the music collection.
  ///
  /// Returns a [List] of [Song] objects.
  Future<List<Song>> getSongs() async {
    int d = 0;
    int offset = 0;
    List<Song> songs = [];
    var params = SearchParams(
        artistCount: 0,
        artistOffset: 0,
        albumCount: 0,
        albumOffset: 0,
        songCount: 500,
        songOffset: offset);
    while (d == 0) {
      params.songOffset = offset;
      var result = await search3('', params);
      songs.addAll(result.songs!);
      offset += 500;
      d = 500 - result.songs!.length;
    }

    return songs;
  }

  /// Get playlists
  ///
  /// Gets all playlists in the music collection.
  ///
  /// Returns a [List] of [Playlist] objects.
  /// These [Playlist] objects do NOT contain the list of [Song] objects.
  Future<List<Playlist>> getPlaylists() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getPlaylists.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.playlists!;
  }

  /// Get playlist
  ///
  /// Gets a playlist by ID.
  ///
  /// Returns a [Playlist] object.
  /// The [Playlist] object contains a list of [Song] objects.
  Future<Playlist> getPlaylist(String playlistId) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getPlaylist.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$playlistId&f=$format'));
    var res = SubSonicResponse.fromJson(json.decode(response.body));
    return res.playlist!;
  }

  @override
  String toString() {
    return '$_url~$_username~$_token~$_salt~$_clientName~$_clientVersion';
  }
}
