import 'package:flutter/material.dart';
import 'package:flutter_technical_assessment/domain/model/address_data.dart';
import 'package:flutter_technical_assessment/domain/services/network/session_manager.dart';
import 'package:flutter_technical_assessment/pallets.dart';
import 'package:flutter_technical_assessment/presentation/pages/coin_address/coin_address_page.dart';
import 'package:flutter_technical_assessment/presentation/widgets/sized_box.dart';
import 'package:flutter_technical_assessment/presentation/widgets/text_view.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  List<AddressData> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataList = (SessionManager.instance.doesUserDataExists()
        ? AddressMainData.fromJson(SessionManager.instance.addressData).data
        : AddressMainData(data: []).data)!;
  }

  final ValueNotifier isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Pallets.background,
      appBar: AppBar(
        backgroundColor: Pallets.blueColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      color: Colors.black,
                      text: 'Created Addresses',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                20.verticalSpace,
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          ...List.generate(
                              dataList.length,
                              (index) => GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CoinAddressPage(
                                            address:
                                                dataList[index].address ?? '',
                                            currencyLink: dataList[index]
                                                    .addressCurrency ??
                                                '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              offset: const Offset(0, 2),
                                              blurRadius: 5,
                                              spreadRadius: 5,
                                            )
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            dataList[index].addressCurrency ??
                                                '',
                                            height: 40,
                                            width: 40,
                                          ),
                                          10.horizontalSpace,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // TextView(
                                                //   color: Colors.black,
                                                //   text: 'Ethereum',
                                                //   fontSize: 14,
                                                //   fontWeight: FontWeight.w600,
                                                // ),
                                                TextView(
                                                  color: Pallets.greyColor,
                                                  text:
                                                      dataList[index].address ??
                                                          '',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),

                          // 16.verticalSpace,
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
