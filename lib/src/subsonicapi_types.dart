import 'dart:convert';

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

class Artist {
  final String? id;
  final String? name;
  final int? albumCount;
  final String? coverArt;
  final String? artistImageUrl;
  final List<Album>? albums;

  Artist({
    this.id,
    this.name,
    this.coverArt,
    this.albumCount,
    this.artistImageUrl,
    this.albums,
  });

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

class ArtistIndex {
  final String? name;
  final List<Artist>? artists;

  ArtistIndex({this.artists, this.name});

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

class Artists {
  final String? ignoredArticles;
  final ArtistIndex? index;

  Artists({this.index, this.ignoredArticles});

  factory Artists.fromJson(Map<String, dynamic>? json) {
    return json != null
        ? Artists(
            ignoredArticles: json['ignoredArticles'],
            index: ArtistIndex.fromJson(json['index'][0]))
        : Artists();
  }
}

class Genre {
  final String? value;
  final int? songCount;
  final int? albumCount;
  final int? duration;
  final String? coverArt;

  Genre(
      {this.value,
      this.songCount,
      this.albumCount,
      this.duration,
      this.coverArt});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
        value: json['value'],
        songCount: json['songCount'],
        albumCount: json['albumCount'],
        duration: json['duration'],
        coverArt: json['coverArt']);
  }
}

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

  SubSonicResponse(
      {required this.status,
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
      this.genres});

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
        musicFolders: json['musicFolders'],
        indexes: json['indexes'],
        directory: json['directory'],
        json: json);
  }
}
