import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkirapp/app/modules/home/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provinceIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;
  var kotaIdTujuan = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provinceIdTujuan = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double weight = 0.0;
  String satuan = "gram";

  late TextEditingController weightControler;

  void ongkoskirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(url, body: {
        "origin": "$kotaIdAsal",
        "destination": "$kotaIdTujuan",
        "weight": "$weight",
        "courier": "$kurir",
      }, headers: {
        "content-type": "application/x-www-form-urlencoded",
        "Key": "64733b60c80d5c2d4903fbdafbeab0fe"
      });
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var resaults = data['rajaongkir']['results'] as List<dynamic>;

      var listAllCourier = Courier.fromJsonList(resaults);
      var courier = listAllCourier[0];
      // print(listAllCourier[0]);
      Get.defaultDialog(
        title: courier.name!,
        content: Column(
          children: courier.costs!.map(
            (e) => ListTile(
              title: Text("${e.service}"),
              subtitle: Text("Rp. ${e.cost![0].value}"),
              trailing: Text(courier.code == "pos" ? "${e.cost![0].etd}" : "${e.cost![0].etd} HARI" ),
            ),
          ).toList(),
        ),
      );
    } catch (err) {
      print(err);
      Get.defaultDialog(
        title: "Gagal",
        middleText: err.toString(),
      );
    }
  }

  // validasi cek ongkir
  void showButton() {
    if (kotaIdAsal != 0 && kotaIdTujuan != 0 && weight > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void editWeight(String value) {
    weight = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        weight = weight * 1000000;
        break;
      case "kwintal":
        weight = weight * 100000;
        break;
      case "ons":
        weight = weight * 100;
        break;
      case "lbs":
        weight = weight * 2204.62;
        break;
      case "pound":
        weight = weight * 2204.62;
        break;
      case "kg":
        weight = weight * 1000;
        break;
      case "hg":
        weight = weight * 100;
        break;
      case "dag":
        weight = weight * 10;
        break;
      case "gram":
        weight = weight;
        break;
      case "dg":
        weight = weight / 10;
        break;
      case "cg":
        weight = weight / 100;
        break;
      case "mg":
        weight = weight / 1000;
        break;

      default:
        weight = weight;
    }
    print("$weight gram");
  }

  void editSatuan(String value) {
    weight = double.tryParse(weightControler.text) ?? 0.0;
    switch (value) {
      case "ton":
        weight = weight * 1000000;
        break;
      case "kwintal":
        weight = weight * 100000;
        break;
      case "ons":
        weight = weight * 100;
        break;
      case "lbs":
        weight = weight * 2204.62;
        break;
      case "pound":
        weight = weight * 2204.62;
        break;
      case "kg":
        weight = weight * 1000;
        break;
      case "hg":
        weight = weight * 100;
        break;
      case "dag":
        weight = weight * 10;
        break;
      case "gram":
        weight = weight;
        break;
      case "dg":
        weight = weight / 10;
        break;
      case "cg":
        weight = weight / 100;
        break;
      case "mg":
        weight = weight / 1000;
        break;

      default:
        weight = weight;
    }

    satuan = value;
    print("$weight gram");
  }

  @override
  void onInit() {
    weightControler = TextEditingController(text: "$weight");
    super.onInit();
  }

  @override
  void onClose() {
    weightControler.dispose();
    super.onClose();
  }
}
