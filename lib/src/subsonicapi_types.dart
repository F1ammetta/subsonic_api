import 'dart:convert';

/// A class representing a song.
class Song {
  /// The ID of the song.
  final String id;

  /// The parent ID of the song.
  final String parent;

  /// The title of the song.
  final String title;

  /// The album of the song.
  final String album;

  /// The artist of the song.
  final String artist;

  /// Whether the song is a directory.
  final bool isDir;

  /// The cover art of the song.
  final String coverArt;

  /// The creation date of the song.
  final String created;

  /// The duration of the song.
  final int duration;

  /// The bit rate of the song.
  final int bitRate;

  /// The size of the song.
  final int size;

  /// The suffix of the song.
  final String suffix;

  /// The content type of the song.
  final String contentType;

  /// Whether the song is a video.
  final bool isVideo;

  /// The path of the song.
  final String path;

  /// The album ID of the song.
  final String albumId;

  /// The artist ID of the song.
  final String artistId;

  /// The type of the song.
  final String type;

  /// The last played date of the song.
  final String played;

  /// Create a [Song] object.
  Song(
      {required this.id,
      required this.parent,
      required this.title,
      required this.album,
      required this.artist,
      required this.isDir,
      required this.coverArt,
      required this.created,
      required this.duration,
      required this.bitRate,
      required this.size,
      required this.suffix,
      required this.contentType,
      required this.isVideo,
      required this.path,
      required this.albumId,
      required this.artistId,
      required this.type,
      required this.played});

  /// Create a [Song] object from a JSON object.
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json['id'],
        parent: json['parent'],
        title: utf8.decode(json['title'].runes.toList()),
        album: utf8.decode(json['album'].runes.toList()),
        artist: utf8.decode(json['artist'].runes.toList()),
        isDir: json['isDir'],
        coverArt: json['coverArt'],
        created: json['created'],
        duration: json['duration'],
        bitRate: json['bitRate'] ?? 0,
        size: json['size'] ?? 0,
        suffix: json['suffix'] ?? '',
        contentType: json['contentType'] ?? '',
        isVideo: json['isVideo'],
        path: utf8.decode((json['path'] ?? '').runes.toList()),
        albumId: json['albumId'] ?? '',
        artistId: json['artistId'],
        type: json['type'] ?? '',
        played: json['played'] ?? '');
  }
}

/// A class representing an album.
class Album {
  /// The ID of the album.
  final String id;

  /// The name of the album.
  final String name;

  /// The cover art of the album.
  final String coverArt;

  /// The number of songs in the album.
  final int songCount;

  /// The creation date of the album.
  final String created;

  /// The duration of the album.
  final int duration;

  /// The artist of the album.
  final String artist;

  /// The ID of the artist of the album.
  final String artistId;

  /// A list of songs in the album.
  final List<Song> songs;

  /// Create an [Album] object.
  Album(
      {required this.id,
      required this.name,
      required this.coverArt,
      required this.songCount,
      required this.created,
      required this.duration,
      required this.artist,
      required this.artistId,
      required this.songs});

  /// Create an [Album] object from a JSON object.
  factory Album.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['song'] == null) {
      return Album(
          id: '',
          name: '',
          coverArt: '',
          songCount: 0,
          created: '',
          duration: 0,
          artist: '',
          artistId: '',
          songs: []);
    }
    List<Song> songs = [];
    for (var song in json['song']) {
      songs.add(Song(
          id: song['id'],
          parent: song['parent'],
          title: utf8.decode(song['title'].runes.toList()),
          album: utf8.decode(song['album'].runes.toList()),
          artist: utf8.decode(song['artist'].runes.toList()),
          isDir: song['isDir'],
          coverArt: song['coverArt'],
          created: song['created'],
          duration: song['duration'],
          bitRate: song['bitRate'],
          size: song['size'],
          suffix: song['suffix'],
          contentType: song['contentType'],
          isVideo: song['isVideo'],
          path: utf8.decode(song['path'].runes.toList()),
          albumId: song['albumId'],
          artistId: song['artistId'],
          played: song['played'] ?? '',
          type: song['type']));
    }

    return Album(
        id: json['id'],
        name: utf8.decode(json['name'].runes.toList()),
        coverArt: json['coverArt'],
        songCount: json['songCount'],
        created: json['created'],
        duration: json['duration'],
        artist: utf8.decode(json['artist'].runes.toList()),
        artistId: json['artistId'],
        songs: songs);
  }

  /// Do NOT use this constructor.
  /// It is only used internally by the API client
  /// because of some inconsistencies in some implementaations of the SubSonic API.
  factory Album.fromSong(Song song, int songCount) {
    return Album(
        id: song.id,
        name: song.album,
        coverArt: song.coverArt,
        songCount: songCount,
        created: song.created,
        duration: song.duration,
        artist: song.artist,
        artistId: song.artistId,
        songs: []);
  }
}

/// A class representing an artist.
class Artist {
  /// The ID of the artist.
  final String id;

  /// The name of the artist.
  final String name;

  /// The number of albums by the artist.
  final int albumCount;

  /// The cover art of the artist.
  final String coverArt;

  /// The artist image URL.
  final String artistImageUrl;

  /// A list of albums by the artist.
  final List<Album> albums;

  /// Create an [Artist] object.
  Artist({
    required this.id,
    required this.name,
    required this.coverArt,
    required this.albumCount,
    required this.artistImageUrl,
    required this.albums,
  });

  /// Create an [Artist] object from a JSON object.
  factory Artist.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Artist(
          id: '',
          name: '',
          albumCount: 0,
          coverArt: '',
          artistImageUrl: '',
          albums: []);
    }
    List<Album> albums = [];

    if (json['album'] != null) {
      for (var album in json['album']) {
        albums.add(Album(
            id: album['id'],
            name: utf8.decode(album['name'].runes.toList()),
            coverArt: album['coverArt'],
            songCount: album['songCount'],
            created: album['created'],
            duration: album['duration'],
            artist: utf8.decode(album['artist'].runes.toList()),
            songs: [],
            artistId: album['artistId']));
      }
    }

    return Artist(
        id: json['id'],
        name: utf8.decode(json['name'].runes.toList()),
        albumCount: json['albumCount'],
        coverArt: json['coverArt'],
        artistImageUrl: json['artistImageUrl'],
        albums: albums);
  }
}

class Playlist {
  /// The ID of the playlist.
  final String id;

  /// The name of the playlist.
  final String name;

  /// The comment of the playlist.
  final String comment;

  /// The owner of the playlist.
  final String owner;

  /// Whether the playlist is public.
  final bool public;

  /// The number of songs in the playlist.
  final int songCount;

  /// The duration of the playlist.
  final int duration;

  /// The creation date of the playlist.
  final String created;

  /// The last modified date of the playlist.
  final String changed;

  /// The cover art of the playlist.
  final String coverArt;

  /// A list of songs in the playlist.
  final List<Song> songs;

  /// Create a [Playlist] object.
  Playlist(
      {required this.id,
      required this.name,
      required this.comment,
      required this.owner,
      required this.public,
      required this.songCount,
      required this.duration,
      required this.created,
      required this.changed,
      required this.coverArt,
      required this.songs});

  /// Create a [Playlist] object from a JSON object.
  factory Playlist.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Playlist(
          id: '',
          name: '',
          comment: '',
          owner: '',
          public: false,
          songCount: 0,
          duration: 0,
          created: '',
          changed: '',
          coverArt: '',
          songs: []);
    }

    List<Song> songlist = [];

    if (json['entry'] != null) {
      for (var song in json['entry']) {
        songlist.add(Song(
            id: song['id'],
            parent: song['parent'],
            title: utf8.decode(song['title'].runes.toList()),
            album: utf8.decode(song['album'].runes.toList()),
            artist: utf8.decode(song['artist'].runes.toList()),
            isDir: song['isDir'],
            coverArt: song['coverArt'],
            created: song['created'],
            duration: song['duration'],
            bitRate: song['bitRate'],
            size: song['size'],
            suffix: song['suffix'],
            contentType: song['contentType'],
            isVideo: song['isVideo'],
            path: utf8.decode(song['path'].runes.toList()),
            albumId: song['albumId'],
            type: song['type'],
            artistId: song['artistId'],
            played: song['played'] ?? ''));
      }
    }

    return Playlist(
        id: json['id'],
        name: json['name'],
        comment: json['comment'] ?? '',
        owner: json['owner'],
        public: json['public'],
        songCount: json['songCount'],
        duration: json['duration'],
        created: json['created'],
        changed: json['changed'],
        coverArt: json['coverArt'],
        songs: songlist);
  }
}

/// A class representing a genre.
class Genre {
  /// The name of the genre.
  final String value;

  /// The number of songs in the genre.
  final int songCount;

  /// The number of albums in the genre.
  final int albumCount;

  /// The total duration of the genre.
  final int duration;

  /// The cover art of the genre.
  final String coverArt;

  /// Create a [Genre] object.
  Genre(
      {required this.value,
      required this.songCount,
      required this.albumCount,
      required this.duration,
      required this.coverArt});

  /// Create a [Genre] object from a JSON object.
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
        value: json['value'],
        songCount: json['songCount'],
        albumCount: json['albumCount'],
        duration: json['duration'],
        coverArt: json['coverArt']);
  }
}

/// [Album] list types
///
/// Determines the type of sorting for the album list.
enum AlbumListType {
  /// Random
  random,

  /// Newest
  newest,

  /// Highest rated
  frequent,

  /// Recently played
  recent,

  /// Starred
  starred,

  /// Alphabetical by name
  alphabeticalByName,

  /// Alphabetical by artist
  alphabeticalByArtist
}

/// A class representing Album search parameters
class AlbumParams {
  /// The type of album list to return.
  AlbumListType type;

  /// The max number of albums to return.
  int size;

  /// The offset of the first album to return.
  int offset;

  /// The start year of the albums to return.
  ///
  /// If null, the start year is not specified.
  /// If larger than the end year, the list will be reversed chronologically.
  String? fromYear;

  /// The end year of the albums to return.
  String? toYear;

  /// The genre of the albums to return.
  String? genre;

  /// Create an [AlbumParams] object.
  AlbumParams(
      {this.type = AlbumListType.alphabeticalByName,
      this.size = 10,
      this.offset = 0,
      this.fromYear,
      this.toYear,
      this.genre}) {
    if (size > 500) {
      size = 500;
    }

    if (size < 0) {
      size = 0;
    }

    if (offset < 0) {
      offset = 0;
    }

    if (offset > size) {
      offset = size;
    }
  }

  @override
  String toString() {
    fromYear ??= '';
    toYear ??= '';
    genre ??= '';
    return 'type=${type.toString().split('.').last}&size=$size&offset=$offset&fromYear=$fromYear&toYear=$toYear&genre=$genre';
  }
}

/// A class representing search parameters
class SearchParams {
  /// The max number of artists to return.
  int artistCount;

  /// The offset of the first artist to return.
  int artistOffset;

  /// The max number of albums to return.
  int albumCount;

  /// The offset of the first album to return.
  int albumOffset;

  /// The max number of songs to return.
  int songCount;

  /// The offset of the first song to return.
  int songOffset;

  /// Create a [SearchParams] object.
  SearchParams(
      {this.artistCount = 20,
      this.artistOffset = 0,
      this.albumCount = 20,
      this.albumOffset = 0,
      this.songCount = 20,
      this.songOffset = 0});

  @override
  String toString() {
    return 'artistCount=$artistCount&artistOffset=$artistOffset&albumCount=$albumCount&albumOffset=$albumOffset&songCount=$songCount&songOffset=$songOffset';
  }
}

/// A class representing a Search Result
class SearchResult {
  /// A list of found artists.
  final List<Artist>? artists;

  /// A list of found albums.
  final List<Album>? albums;

  /// A list of found songs.
  final List<Song>? songs;

  /// Create a [SearchResult] object.
  SearchResult({this.artists, this.albums, this.songs});

  /// Create a [SearchResult] object from a JSON object.
  factory SearchResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SearchResult();
    }
    return SearchResult(
        artists: json['artist'] != null
            ? (json['artist'] as List)
                .map((artist) => Artist.fromJson(artist))
                .toList()
            : null,
        albums: json['album'] != null
            ? (json['album'] as List)
                .map((album) => Album.fromJson(album))
                .toList()
            : null,
        songs: json['song'] != null
            ? (json['song'] as List).map((song) => Song.fromJson(song)).toList()
            : null);
  }
}

/// A class representing a license.
class License {
  /// Whether the license is valid.
  final bool? valid;

  /// The email associated with the license.
  final String? email;

  /// The expiration date of the license.
  final String? licenseExpires;

  /// Create a [License] object.
  License({this.valid, this.email, this.licenseExpires});

  /// Create a [License] object from a JSON object.
  factory License.fromJson(Map<String, dynamic>? json) {
    return json != null
        ? License(
            valid: json['valid'],
            email: json['email'],
            licenseExpires: json['licenseExpires'])
        : License();
  }
}
