/// A library to interact with the Subsonic API.
///
/// This library is a wrapper around the Subsonic API. It provides a way to
/// interact with the Subsonic API using Dart in a type-safe way.
///
/// The library is designed to be used with the Subsonic API version 1.16.1.
/// It may work with other versions of the API, but it has not been tested.
///
/// To use this library, you will need to create a [SubSonicClient] object and
/// use it to interact with the Subsonic API. The [SubSonicClient] object
/// requires a URL to the Subsonic server, a username, a token, a salt, an
/// application name, and an application version.
library;

export 'src/subsonicapi_base.dart';
export 'src/subsonicapi_types.dart';

// TODO: Export any libraries intended for clients of this package.
