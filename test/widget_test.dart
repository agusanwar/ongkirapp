// test api
import 'package:http/http.dart' as http;

Future<void> main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response = await http.get(url, headers: {
    "Key": "64733b60c80d5c2d4903fbdafbeab0fe"
  });

  print(response.body);
}
