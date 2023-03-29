// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//
// class CoinAddressController extends StateNotifier<CoinAddressState>{
//
//   CoinAddressController(this.ref) : super(CoinAddressInitial());
//   final StateNotifierProviderRef ref;
//
//   Future<void> caller() async {
//     try {
//       state = CoinAddressLoading();
//
//       state = CoinAddressSuccess();
//     } catch (e) {
//       state = CoinAddressError(e.toString());
//     }
//   }
//
//
// }
//
//
// final coin_addressProvider =
//     StateNotifierProvider<CoinAddressController, CoinAddressState>((ref) {
//   return CoinAddressController(ref);
// });
//
//
//
//  abstract class CoinAddressState {}
//
//  class CoinAddressInitial extends CoinAddressState {}
//
//  class CoinAddressLoading extends CoinAddressState {}
//
//  class CoinAddressSuccess extends CoinAddressState {}
//
//  class CoinAddressError extends CoinAddressState {
//    final String message;
//
//    CoinAddressError(this.message);
//  }
