import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkirapp/app/modules/home/views/widget/city.dart';
import 'package:ongkirapp/app/modules/home/views/widget/province.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkir App'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
            Provicies(),
           Obx(() => controller.hiddenKota.isTrue ? SizedBox() : Cities(pronvinceId: controller.provinceId.value,)),
        ],
      ),
    );
  }
}



