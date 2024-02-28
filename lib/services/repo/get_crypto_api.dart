import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virench_trial_task/presentation/home/home_controller.dart';
import 'package:virench_trial_task/services/handler/handler.dart';
import 'package:virench_trial_task/services/handler/http_urls.dart';
import 'package:virench_trial_task/services/model/get_crypto_model.dart';
import 'package:virench_trial_task/utils/const.dart';

void getCurrenciesApi({required bool initialData}) async {
  HomeController con = Get.put(HomeController());

  try {
    if (initialData == true) {
      con.isLoading.value = true;
      con.cryptoList.clear();
      con.page.value = 0;
      con.nextPageStop.value = false;
    } else {
      con.paginationLoading.value = true;
    }

    http.Response response = await ApiHandler.get(
      url:
          '${HttpUrl().baseUrl}${HttpUrl().cryptoCurrencies}?CMC_PRO_API_KEY=$keyApi&limit=20&start=${con.page.value}1',
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202 ||
        response.statusCode == 203 ||
        response.statusCode == 204) {
      var decoded = getCryptoModelFromMap(response.body);
      con.page.value = con.page.value + 2;
      if (decoded.data!.isNotEmpty) {
        for (var element in decoded.data!) {
          con.cryptoList.add(element);
        }
        con.nextPageStop.value = false;
      } else {
        con.nextPageStop.value = true;
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  } finally {
    con.isLoading.value = false;
    con.paginationLoading.value = false;
    con.update();
  }
}
