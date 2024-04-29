import 'dart:convert';

/// A class representing a song.
class Song {
  final String? id;
  final String? parent;
  final String? title;
  final String? album;
  final String? artist;
  final bool? isDir;
  final String? coverArt;
  final String? created;
  final int? duration;
  final int? bitRate;
  final int? size;
  final String? suffix;
  final String? contentType;
  final bool? isVideo;
  final String? path;
  final String? albumId;
  final String? artistId;
  final String? type;

  /// Create a [Song] object.
  Song(
      {this.id,
      this.parent,
      this.title,
      this.album,
      this.artist,
      this.isDir,
      this.coverArt,
      this.created,
      this.duration,
      this.bitRate,
      this.size,
      this.suffix,
      this.contentType,
      this.isVideo,
      this.path,
      this.albumId,
      this.artistId,
      this.type});

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
        bitRate: json['bitRate'],
        size: json['size'],
        suffix: json['suffix'],
        contentType: json['contentType'],
        isVideo: json['isVideo'],
        path: utf8.decode(json['path'].runes.toList()),
        albumId: json['albumId'],
        artistId: json['artistId'],
        type: json['type']);
  }
}

/// A class representing an album.
class Album {
  final String? id;
  final String? name;
  final String? coverArt;
  final int? songCount;
  final String? created;
  final int? duration;
  final String? artist;
  final String? artistId;
  final List<Song>? songs;

  /// Create an [Album] object.
  Album(
      {this.id,
      this.name,
      this.coverArt,
      this.songCount,
      this.created,
      this.duration,
      this.artist,
      this.artistId,
      this.songs});

  /// Create an [Album] object from a JSON object.
  factory Album.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Album();
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
}

/// A class representing an artist.
class Artist {
  final String? id;
  final String? name;
  final int? albumCount;
  final String? coverArt;
  final String? artistImageUrl;
  final List<Album>? albums;

  /// Create an [Artist] object.
  Artist({
    this.id,
    this.name,
    this.coverArt,
    this.albumCount,
    this.artistImageUrl,
    this.albums,
  });

  /// Create an [Artist] object from a JSON object.
  factory Artist.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Artist();
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

/// A class representing a genre.
class Genre {
  final String? value;
  final int? songCount;
  final int? albumCount;
  final int? duration;
  final String? coverArt;

  /// Create a [Genre] object.
  Genre(
      {this.value,
      this.songCount,
      this.albumCount,
      this.duration,
      this.coverArt});

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

/// A class representing a license.
class License {
  final String? valid;
  final String? email;
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
