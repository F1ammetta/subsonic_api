# SubSonic API Wrapper

Package for interfacing with any [SubSonic API](https://www.subsonic.org/pages/api.jsp) compatible server.

## Features

    - Fetch

## Getting started

Just add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  subsonic_api: ^0.0.1
```

Then import the package in your Dart code:

```dart
import 'package:subsonic_wrapper/subsonic_api.dart';
```

## Usage

To use this package, you'd need to generate your authentication token and salt.

```dart
String salt = SubSonicClient.createSalt();

String token = SubSonicClient.createToken('password', salt);
```

this is the preffered way to generate the token and salt, since it doen't expose the password anywhere in the application.

Then, you need to create a `SubSonicClient` object with the server URL, username, token, salt, client name and version.

```dart

SubSonicClient client = SubSonicClient(
    'http://server:port',
    'admin',
    token,
    salt,
    'Client Name',
    '1.0.0'
);
```

After that, you can use the client to fetch data from the server.

```dart
Future<void> fetch() async {
    SubSonicResponse response = await client.getArtists();
}
```




## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
