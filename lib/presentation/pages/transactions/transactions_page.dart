import 'package:flutter/material.dart';
import 'transactions_controller.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});


  @override
  TransactionsPageState createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      dialogKey.currentState?.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:  AppBar(),
      body:  Container(),
    );
  }
}
  