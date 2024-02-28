import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:virench_trial_task/main.dart';
import 'package:virench_trial_task/presentation/currencies_detail/currencies_detail_screen.dart';
import 'package:virench_trial_task/presentation/home/home_controller.dart';
import 'package:virench_trial_task/services/model/get_crypto_model.dart';
import 'package:virench_trial_task/services/repo/get_crypto_api.dart';
import 'package:virench_trial_task/utils/app_color.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          title: const Text(
            "Crypto Currencies",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              dividerColor: AppColors.whiteColor,
              tabs: [
                Tab(
                  icon: Text(
                    "Currencies",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Tab(
                  icon: Text(
                    "Favorites",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                _FirstTab(con: con),
                const _FavoriteTab(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Currencies Tab

class _FirstTab extends StatelessWidget {
  final HomeController con;

  const _FirstTab({required this.con});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => con.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                getCurrenciesApi(initialData: true);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => con.cryptoList.isNotEmpty
                          ? SingleChildScrollView(
                              controller: con.newScrollController,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: con.cryptoList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return _CryptoTile(
                                    data: con.cryptoList[index],
                                  );
                                },
                              ))
                          : const Center(
                              child: Text(
                                "No Crypto Currencies Found",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Obx(
                    () => con.paginationLoading.value
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
    );
  }
}

/// Favorite Tab

class _FavoriteTab extends StatelessWidget {
  const _FavoriteTab();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Obx(
        () => baseController!.favoriteList.isNotEmpty
            ? SingleChildScrollView(
                child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: baseController!.favoriteList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _CryptoTile(
                    data: baseController!.favoriteList[index],
                  );
                },
              ))
            : const Center(
                child: Text(
                  "No Favorite Currencies Found",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

/// Crypto Tile

class _CryptoTile extends StatelessWidget {
  final CryptoData data;

  const _CryptoTile({required this.data});

  Color _getRandomColor() {
    Random random = Random();

    int min = 50;
    int max = 200;

    int red = min + random.nextInt(max - min);
    int green = min + random.nextInt(max - min);
    int blue = min + random.nextInt(max - min);

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CurrenciesDetailScreen(data: data));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: _getRandomColor(),
              radius: 22,
              child: Text(
                (data.name ?? "")[0].toUpperCase(),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    data.symbol ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rank",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
                Center(
                  child: Text(
                    data.rank ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white54,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
