// To parse this JSON data, do
//
//     final getCryptoModel = getCryptoModelFromMap(jsonString);

import 'dart:convert';

GetCryptoModel getCryptoModelFromMap(String str) =>
    GetCryptoModel.fromMap(json.decode(str));

String getCryptoModelToMap(GetCryptoModel data) => json.encode(data.toMap());

class GetCryptoModel {
  List<CryptoData>? data;

  GetCryptoModel({
    this.data,
  });

  factory GetCryptoModel.fromMap(Map<String, dynamic> json) => GetCryptoModel(
        data: List<CryptoData>.from(
            json["data"].map((x) => CryptoData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class CryptoData {
  String? id;
  String? rank;
  String? name;
  String? symbol;
  String? slug;
  String? isActive;
  DateTime? firstHistoricalData;
  DateTime? lastHistoricalData;
  Platform? platform;

  CryptoData({
    this.id,
    this.rank,
    this.name,
    this.symbol,
    this.slug,
    this.isActive,
    this.firstHistoricalData,
    this.lastHistoricalData,
    this.platform,
  });

  factory CryptoData.fromJson(Map<String, dynamic> json) => CryptoData(
    id: (json["id"] ?? "").toString(),
    rank: (json["rank"] ?? "").toString(),
    name: (json["name"] ?? "").toString(),
    symbol: (json["symbol"] ?? "").toString(),
    slug: (json["slug"] ?? "").toString(),
    isActive: (json["is_active"] ?? "").toString(),
    firstHistoricalData: json["first_historical_data"] != null
        ? DateTime.parse(json["first_historical_data"])
        : DateTime.now(),
    lastHistoricalData: json["last_historical_data"] != null
        ? DateTime.parse(json["last_historical_data"])
        : DateTime.now(),
    platform: json["platform"] != null
        ? Platform.fromMap(json["platform"])
        : Platform(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rank": rank,
    "name": name,
    "symbol": symbol,
    "slug": slug,
    "is_active": isActive,
    "first_historical_data": firstHistoricalData!.toIso8601String(),
    "last_historical_data": lastHistoricalData!.toIso8601String(),
    "platform": platform,
  };

  factory CryptoData.fromMap(Map<String, dynamic> json) => CryptoData(
        id: (json["id"] ?? "").toString(),
        rank: (json["rank"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        symbol: (json["symbol"] ?? "").toString(),
        slug: (json["slug"] ?? "").toString(),
        isActive: (json["is_active"] ?? "").toString(),
        firstHistoricalData: json["first_historical_data"] != null
            ? DateTime.parse(json["first_historical_data"])
            : DateTime.now(),
        lastHistoricalData: json["last_historical_data"] != null
            ? DateTime.parse(json["last_historical_data"])
            : DateTime.now(),
        platform: json["platform"] != null
            ? Platform.fromMap(json["platform"])
            : Platform(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rank": rank,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "is_active": isActive,
        "first_historical_data": firstHistoricalData!.toIso8601String(),
        "last_historical_data": lastHistoricalData!.toIso8601String(),
        "platform": platform,
      };
}

class Platform {
  String? id;
  String? name;
  String? symbol;
  String? slug;
  String? tokenAddress;

  Platform({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.tokenAddress,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        symbol: (json["symbol"] ?? "").toString(),
        slug: (json["slug"] ?? "").toString(),
        tokenAddress: (json["token_address"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "token_address": tokenAddress,
      };

  factory Platform.fromMap(Map<String, dynamic> json) => Platform(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        symbol: (json["symbol"] ?? "").toString(),
        slug: (json["slug"] ?? "").toString(),
        tokenAddress: (json["token_address"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "token_address": tokenAddress,
      };
}
