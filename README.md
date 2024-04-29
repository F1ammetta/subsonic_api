# SubSonic API Wrapper

Package for interfacing with any [SubSonic API](https://www.subsonic.org/pages/api.jsp) compatible server.

## Features

    - Fetch Artists and Albums from the server

## Getting started

Just add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  subsonic_api: ^0.0.3
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
