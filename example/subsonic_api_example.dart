import 'package:subsonic_api/subsonic_api.dart';

void main() async {
  String salt = createSalt();
  String token = createToken(salt, 'password');
  SubSonicClient client = SubSonicClient('http://localhost:4040', 'username',
      token, salt, 'SubSonicApiExample', '0.0.1');

  var response = await client.ping();

  print(response.status);
  print(client.toString());
}
