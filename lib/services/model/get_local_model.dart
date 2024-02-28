import 'dart:convert';

import 'package:virench_trial_task/services/model/get_crypto_model.dart';

List<CryptoData> favoriteModelFromJson(String str) =>
    List<CryptoData>.from(json.decode(str).map((x) => CryptoData.fromJson(x)));

String favoriteModelToJson(List<CryptoData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
