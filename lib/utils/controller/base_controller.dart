import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:virench_trial_task/services/model/get_crypto_model.dart';
import 'package:virench_trial_task/services/model/get_local_model.dart';

class BaseController extends GetxController {
  RxList<CryptoData> favoriteList = <CryptoData>[].obs;

  void addToFavorite() {
    final box = GetStorage();

    box.write('favorite', jsonEncode(favoriteList.toList()));
  }

  void getFavorite() {
    final box = GetStorage();

    if (box.read('favorite') != null) {
      favoriteList.value = favoriteModelFromJson(box.read('favorite'));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFavorite();
  }
}
