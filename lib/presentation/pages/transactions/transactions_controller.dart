// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//
// class TransactionsController extends StateNotifier<TransactionsState>{
//
//   TransactionsController(this.ref) : super(TransactionsInitial());
//   final StateNotifierProviderRef ref;
//
//   Future<void> caller() async {
//     try {
//       state = TransactionsLoading();
//
//       state = TransactionsSuccess();
//     } catch (e) {
//       state = TransactionsError(e.toString());
//     }
//   }
//
//
// }
//
//
// final transactionsProvider =
//     StateNotifierProvider<TransactionsController, TransactionsState>((ref) {
//   return TransactionsController(ref);
// });
//
//
//
//  abstract class TransactionsState {}
//
//  class TransactionsInitial extends TransactionsState {}
//
//  class TransactionsLoading extends TransactionsState {}
//
//  class TransactionsSuccess extends TransactionsState {}
//
//  class TransactionsError extends TransactionsState {
//    final String message;
//
//    TransactionsError(this.message);
//  }
