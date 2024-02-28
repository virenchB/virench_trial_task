import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virench_trial_task/main.dart';
import 'package:virench_trial_task/presentation/currencies_detail/currencies_detail_controller.dart';
import 'package:virench_trial_task/services/model/get_crypto_model.dart';
import 'package:virench_trial_task/utils/app_color.dart';

class CurrenciesDetailScreen extends StatelessWidget {
  final CryptoData data;

  CurrenciesDetailScreen({super.key, required this.data});

  final CurrenciesDetailController con = Get.put(CurrenciesDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: Text(
          data.name ?? "Currencies Detail",
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () => Container(
              margin: const EdgeInsets.only(right: 12, top: 12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor,
              ),
              child: IconButton(
                onPressed: () {
                  if (baseController!.favoriteList
                      .where((p0) => p0.id == data.id)
                      .isNotEmpty) {
                    baseController!.favoriteList
                        .removeWhere((p0) => p0.id == data.id);
                  } else {
                    baseController!.favoriteList.add(data);
                  }
                  baseController!.addToFavorite();
                },
                icon: baseController!.favoriteList
                        .where((p0) => p0.id == data.id)
                        .isNotEmpty
                    ? const Icon(
                        Icons.favorite,
                        color: AppColors.redColor,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: AppColors.blackColor,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DataTile(
              title: "Currencies Name :",
              value: data.name ?? "",
            ),
            const SizedBox(height: 6),
            _DataTile(
              title: "Symbol :",
              value: data.symbol ?? "",
            ),
            const SizedBox(height: 6),
            _DataTile(
              title: "First Historical Date :",
              value: DateFormat('dd-MM-yyyy hh:mm a')
                  .format(data.firstHistoricalData!),
            ),
            const SizedBox(height: 6),
            _DataTile(
              title: "Last Historical Date :",
              value: DateFormat('dd-MM-yyyy hh:mm a')
                  .format(data.lastHistoricalData!),
            ),
            if ((data.platform?.name ?? "").toString().isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'PlatForm',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 6),
                _DataTile(
                  title: "PlatForm Name : ",
                  value: data.platform?.name ?? "",
                ),
                const SizedBox(height: 6),
                _DataTile(
                  title: "PlatForm Symbol : ",
                  value: data.platform?.symbol ?? "",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// Data Tile

class _DataTile extends StatelessWidget {
  final String title;
  final String value;

  const _DataTile({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
