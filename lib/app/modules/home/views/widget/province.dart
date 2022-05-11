import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ongkirapp/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ongkirapp/app/modules/home/province_model.dart';

class Provicies extends GetView<HomeController> {
  const Provicies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20
      ),
      child: DropdownSearch<Province>(
        showClearButton: true,
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Provice",
        ),
        onFind: (String? filter) async {
          Uri url =
              Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final response = await http.get(url,
                headers: {"Key": "64733b60c80d5c2d4903fbdafbeab0fe"});

            var data = jsonDecode(response.body) as Map<String, dynamic>;

            var statusCode = data['rajaongkir']['status']['code'];

            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var listAllProvice =
                data['rajaongkir']['results'] as List<dynamic>;
            var models = Province.fromJsonList(listAllProvice);
            return models;
          } catch (e) {
            print(e);
            return List<Province>.empty();
          }
        },
         onChanged: (province) {
          //province tidak null
          if (province != null) {
            controller.hiddenKota.value = false;
            controller.provinceId.value = int.parse(province.provinceId!);
          } else{
             controller.hiddenKota.value = true;
             controller.provinceId.value = 0;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '${item.province}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
        itemAsString: (item) => item!.province!,
      ),
    );
  }
}