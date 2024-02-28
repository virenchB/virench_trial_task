import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virench_trial_task/services/model/get_crypto_model.dart';
import 'package:virench_trial_task/services/repo/get_crypto_api.dart';

class HomeController extends GetxController {
  RxList<CryptoData> cryptoList = <CryptoData>[].obs;

  RxBool isLoading = false.obs;
  RxBool paginationLoading = false.obs;

  ScrollController newScrollController = ScrollController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getCurrenciesApi(initialData: true);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    manageScrollController();
  }

  RxInt page = 0.obs;
  RxBool nextPageStop = false.obs;

  void manageScrollController() async {
    newScrollController.addListener(
      () {
        if (newScrollController.position.maxScrollExtent ==
            newScrollController.position.pixels) {
          if (nextPageStop.isFalse) {
            getCurrenciesApi(initialData: false);
          }
        }
      },
    );
  }
}
