enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL = "https://api.tatum.io/v3/";
  static const String PRODUCTION_URL = "https://api.tatum.io/v3/";
  static final String coreBaseUrl =
      environment == Environment.staging ? STAGING_URL : PRODUCTION_URL;

  // types eg:ethereum or polygon

  static String generateWallet(type) => '$type/wallet';

  static String genAddress(type, xpub, index) => '$type/address/$xpub/$index';

  static String getWalletBalance(
    type,
    address,
  ) =>
      '$type/account/balance/$address';
}
