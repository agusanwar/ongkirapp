import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  // validasi cek ongkir
  void showButton(){
    if (kotaIdAsal != 0 &&
        kotaIdTujuan != 0 && 
        weight > 0 &&
        kurir != "") {
        hiddenButton.value = false;
      }else{
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
