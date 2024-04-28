import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'subsonicapi_types.dart';

class SubSonicClient {
  final String _url;
  final String _username;
  final String _token;
  final String _salt;
  final String _clientName;
  final String _clientVersion;
  final String format = 'json';

  SubSonicClient(this._url, this._username, this._token, this._salt,
      this._clientName, this._clientVersion);

  /// Create a salt
  ///
  /// Creates a salt for use in creating a token.
  static String createSalt() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Create a token
  ///
  /// Creates a token for use in authenticating with the Subsonic server.
  static String createToken(String password, String salt) {
    return md5.convert(utf8.encode(password + salt)).toString();
  }

  /// Ping the server
  ///
  /// Pings the server to check if it is online.
  /// Returns a [SubSonicResponse] object.
  Future<SubSonicResponse> ping() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/ping.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
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
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains an [Artists] object.
  Future<SubSonicResponse> getArtists() async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getArtists.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  /// Get artist
  ///
  /// Gets an artist by ID.
  ///
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains an [Artist] object.
  /// The [Artist] object contains a list of [Album] objects.
  Future<SubSonicResponse> getArtist(String artistId) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getArtist.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$artistId&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }

  /// Get album
  ///
  /// Gets an album by ID.
  ///
  /// Returns a [SubSonicResponse] object.
  /// The [SubSonicResponse] object contains an [Album] object.
  /// The [Album] object contains a list of [Song] objects.
  Future<SubSonicResponse> getAlbum(String album) async {
    final response = await http.get(Uri.parse(
        '$_url/rest/getAlbum.view?u=$_username&t=$_token&s=$_salt&c=$_clientName&v=$_clientVersion&id=$album&f=$format'));
    return SubSonicResponse.fromJson(json.decode(response.body));
  }
}
