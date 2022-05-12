import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkirapp/app/modules/home/views/widget/city.dart';
import 'package:ongkirapp/app/modules/home/views/widget/province.dart';
import 'package:ongkirapp/app/modules/home/views/widget/weight.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 40, 173),
        title: Text('Ongkir Kirim App'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Provicies(
            type: "asal",
          ),
          Obx(() => controller.hiddenKotaAsal.isTrue
              ? SizedBox()
              : Cities(
                  pronvinceId: controller.provinceIdAsal.value,
                  type: "asal",
                )),
          Provicies(
            type: "tujuan",
          ),
          Obx(() => controller.hiddenKotaTujuan.isTrue
              ? SizedBox()
              : Cities(
                  pronvinceId: controller.provinceIdTujuan.value,
                  type: "ttujuan",
                )),
          WeightBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: DropdownSearch<Map<String, dynamic>>(
                mode: Mode.MENU,
                showClearButton: true,
                items: [
                  {"code": "JNE", "name": "jalur nugraha ekakurir (JNE)"},
                  {"code": "TIKI", "name": "titipan kilat (TIKI)"},
                  {"code": "POS", "name": "perusahaan optional surat (POS)"},
                ],
                dropdownSearchDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Tipe Kurir",
                    hintText: "Pilih tipe kurir"),
                onChanged: (value) {
                  if (value != null) {
                    controller.kurir.value = value["code"];
                  } else {
                    controller.hiddenButton.value = true;
                    controller.kurir.value = "";
                  }
                },
                itemAsString: (item) => "${item!['name']}",
                popupItemBuilder: (context, item, isSelected) => Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "${item['name']}",
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
          ),
          Obx(
            () => controller.hiddenButton.isTrue
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {},
                    child: Text('Cek Ongkos Kirim'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Color.fromARGB(255, 13, 40, 173)),
                  ),
          ),
        ],
      ),
    );
  }
}
