import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkirapp/app/modules/home/controllers/home_controller.dart';


class WeightBarang extends GetView<HomeController> {
  const WeightBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.weightControler,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Input Berat Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => controller.editWeight(value)
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 120,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItems: true,
              showSearchBox: true,
              items: [
                "ton", 
                "kwintal", 
                "ons", 
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
                ],
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Satuan",
                hintText: "Satuan",
              ),
              onChanged: (value) => controller.editSatuan(value!),
              selectedItem: "gram",
          ),
          ),
        ],
      ),
    );
  }
}