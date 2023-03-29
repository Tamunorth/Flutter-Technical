import 'dart:math';

import 'package:flutter_technical_assessment/domain/dto/GenAddressRes.dart';
import 'package:flutter_technical_assessment/domain/dto/GenWalletRes.dart';
import 'package:flutter_technical_assessment/domain/dto/GetWalletBalance.dart';
import 'package:flutter_technical_assessment/domain/services/network/network_imp_service.dart';
import 'package:flutter_technical_assessment/domain/services/network/url_config.dart';

class CoinImpService {
  final NetworkService networkService = NetworkService();

  Future<GenWalletRes> createWallet(String type) async {
    try {
      final fs = await networkService.call(
          UrlConfig.generateWallet(type), RequestMethod.get);

      logger.e(fs.data);

      return GenWalletRes.fromJson(fs.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenAddressRes> genAddress(String type, GenWalletRes res) async {
    final rand = Random(5);
    try {
      final fs = await networkService.call(
          UrlConfig.genAddress(
            type,
            res.xpub,
            0,
          ),
          RequestMethod.get);

      logger.e(fs.data);

      return GenAddressRes.fromJson(fs.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetWalletBalance> getBalance(String type, String address) async {
    final rand = Random(5);
    try {
      final fs = await networkService.call(
          UrlConfig.getWalletBalance(
            type,
            address,
          ),
          RequestMethod.get);

      logger.e(fs.data);

      return GetWalletBalance.fromJson(fs.data);
    } catch (e) {
      rethrow;
    }
  }
}
