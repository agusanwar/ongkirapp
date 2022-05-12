// test api
import 'package:http/http.dart' as http;

// test api province
// Future<void> main() async {
//   Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
//   final response = await http.get(url, headers: {
//     "content-type": "application/x-www-form-urlencoded",
//     "Key": "64733b60c80d5c2d4903fbdafbeab0fe"
//   });

//   print(response.body);
// }

// test api cost
Future<void> main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(
    url, 
    body: {
      "origin": "501",
      "destination": "114",
      "weight": "1700",
      "courier": "jne"
    },
    headers: {
    "content-type": "application/x-www-form-urlencoded",
    "Key": "64733b60c80d5c2d4903fbdafbeab0fe"
  });

  print(response.body);
}
