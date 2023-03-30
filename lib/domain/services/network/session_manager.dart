import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_imp_service.dart';

class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;
  FlutterSecureStorage? secureStorage;

  static SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = await FlutterSecureStorage();
  }

  static const String KEY_USERS_DATA = 'usersData';
  static const String KEY_AUTH_TOKEN = 'authToken';
  static const String KEY_USE_BIO = 'useBiometrics';
  static const String KEY_AUTH_PASS = 'password_koey';
  static const String KEY_BALANCE = 'balance';
  static const String KEY_IS_LOGIN = 'is_logged_in';
  static const String IS_CONTACT_PERMITTED = 'permit_contact';
  static const String KEY_USER_EMAIL = 'logged_in_user_email';

  Map<String, dynamic> get addressData =>
      json.decode(sharedPreferences!.getString(KEY_USERS_DATA) ?? '');

  set addressData(Map map) =>
      sharedPreferences!.setString(KEY_USERS_DATA, json.encode(map));

  bool doesUserDataExists() {
    return sharedPreferences!.containsKey(KEY_USERS_DATA);
  }

  set permitContact(bool allowed) {
    sharedPreferences!.setBool(IS_CONTACT_PERMITTED, allowed);
  }

  bool get permitContact =>
      sharedPreferences!.getBool(IS_CONTACT_PERMITTED) ?? false;

  bool get useBio => sharedPreferences!.getBool(KEY_USE_BIO) ?? false;

  String get authToken => sharedPreferences!.getString(KEY_AUTH_TOKEN) ?? '';

  String get userEmail => sharedPreferences!.getString(KEY_USER_EMAIL) ?? '';

  Future<String?>? get userPassKeyGet async =>
      await secureStorage?.read(key: KEY_AUTH_PASS);

  // Future<String> getUserPassKey() async =>
  //     await secureStorage?.read(key: KEY_AUTH_PASS) ?? '';

  set authToken(String authToken) =>
      sharedPreferences!.setString(KEY_AUTH_TOKEN, authToken);

  set useBio(bool useBio) => sharedPreferences!.setBool(KEY_USE_BIO, useBio);

  set userEmail(String userEmail) =>
      sharedPreferences!.setString(KEY_USER_EMAIL, userEmail);

  set userPassKeySet(String? userPassKey) =>
      secureStorage?.write(key: KEY_AUTH_PASS, value: userPassKey);

  String get balance => sharedPreferences!.getString(KEY_BALANCE) ?? '';

  set balance(String balance) =>
      sharedPreferences!.setString(KEY_BALANCE, balance);

  set isLoggedIn(bool loggedIn) {
    sharedPreferences!.setBool(KEY_IS_LOGIN, loggedIn);
  }

  bool get isLoggedIn => sharedPreferences!.getBool(KEY_IS_LOGIN) ?? false;

  Future<bool> logOut() async {
    logger.i('clearning');

    final holdEmail = sharedPreferences?.getString(KEY_USER_EMAIL);
    final holdPass = sharedPreferences?.getString(KEY_BALANCE);
    final holdUseBio = sharedPreferences?.getBool(KEY_USE_BIO);
    await sharedPreferences!.clear();

    sharedPreferences?.setString(KEY_USER_EMAIL, holdEmail ?? '');
    sharedPreferences?.setString(KEY_BALANCE, holdPass ?? '');
    sharedPreferences?.setBool(KEY_USE_BIO, holdUseBio ?? false);

    await secureStorage?.deleteAll();

    return true;
  }
}
