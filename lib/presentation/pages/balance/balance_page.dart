import 'package:flutter/material.dart';
import 'package:flutter_technical_assessment/pallets.dart';
import 'package:flutter_technical_assessment/presentation/widgets/sized_box.dart';
import 'package:flutter_technical_assessment/presentation/widgets/text_view.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  BalancePageState createState() => BalancePageState();
}

class BalancePageState extends State<BalancePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Pallets.background,
      appBar: AppBar(
        backgroundColor: Pallets.blueColor,
        title: TextView(
          text: 'Balance',
          fontSize: 20,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Pallets.blueColor,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        color: Colors.white,
                        text: 'Portfolio',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      21.verticalSpace,
                      TextView(
                        color: Colors.white,
                        text: 'Holding value',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      TextView(
                        color: Colors.white,
                        text: '₹0.00000',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                      21.verticalSpace,
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                color: Colors.white,
                                text: 'Ledger Balance',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              TextView(
                                color: Colors.white,
                                text: '₹0.00000',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          21.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                color: Colors.white,
                                text: 'Available Balance',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              TextView(
                                color: Colors.white,
                                text: '₹0.00000',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Pallets.blueColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: TextView(
                            color: Colors.white,
                            text: 'Deposit',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: Pallets.blueColor, width: 1),
                        ),
                        child: Center(
                          child: TextView(
                            color: Pallets.blueColor,
                            text: 'Withdraw',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      color: Colors.black,
                      text: 'Transactions',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                20.verticalSpace,
                ...List.generate(
                  1,
                  (index) => const BalanceTile(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceTile extends StatelessWidget {
  const BalanceTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                'https://ethereum.org/static/a183661dd70e0e5c70689a0ec95ef0ba/81d9f/eth-diamond-purple.webp',
                height: 40,
                width: 40,
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    color: Colors.black,
                    text: 'Ethereum',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextView(
                    color: Pallets.greyColor,
                    text: '0.0000000 ETH',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
