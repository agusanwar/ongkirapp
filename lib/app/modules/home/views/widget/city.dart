import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ongkirapp/app/modules/home/city_model.dart';

class Cities extends StatelessWidget {
  const Cities({
    Key? key,
    required this.pronvinceId
  }) : super(key: key);

  final int pronvinceId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20
      ),
      child: DropdownSearch<City>(
        showClearButton: true,
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "City",
        ),
        onFind: (String? filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/city?province=$pronvinceId");
          try {
            final response = await http.get(url,
                headers: {"Key": "64733b60c80d5c2d4903fbdafbeab0fe"});

            var data = jsonDecode(response.body) as Map<String, dynamic>;

            var statusCode = data['rajaongkir']['status']['code'];

            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var listAllCity =
                data['rajaongkir']['results'] as List<dynamic>;
            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        onChanged: (province) {
          //province tidak null
          if (province != null) {
            print(province.province);
          } else{
            print("Tidak memilih kota / kabupaten");
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '${item.type} ${item.cityName}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
        itemAsString: (item) =>   '${item!.type} ${item.cityName}',
      ),
    );
  }
}
