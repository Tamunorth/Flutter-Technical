import 'package:flutter/material.dart';
import 'package:flutter_technical_assessment/domain/services/coin_imp_service.dart';
import 'package:flutter_technical_assessment/domain/services/network/network_imp_service.dart';
import 'package:flutter_technical_assessment/pallets.dart';
import 'package:flutter_technical_assessment/presentation/pages/coin_address/coin_address_page.dart';
import 'package:flutter_technical_assessment/presentation/widgets/sized_box.dart';
import 'package:flutter_technical_assessment/presentation/widgets/text_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  final ValueNotifier isLoading = ValueNotifier(false);

  Future<String> createWalletAddress(String type) async {
    isLoading.value = true;

    try {
      final res = await CoinImpService().createWallet(type);

      final walletAddress = await CoinImpService().genAddress(type, res);

      logger.e(walletAddress.address);

      return walletAddress.address ?? '';
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Pallets.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                          text: 'Deposit INR',
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
                        border: Border.all(color: Pallets.blueColor, width: 1),
                      ),
                      child: Center(
                        child: TextView(
                          color: Pallets.blueColor,
                          text: 'Withdraw INR',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
              TextView(
                color: Colors.black,
                text: 'Available Currencies',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              20.verticalSpace,
              ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final retValue =
                                await createWalletAddress('ethereum');

                            if (retValue != null) {
                              Future.delayed(
                                Duration.zero,
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CoinAddressPage(
                                      address: retValue,
                                      currencyLink:
                                          'https://ethereum.org/static/a183661dd70e0e5c70689a0ec95ef0ba/81d9f/eth-diamond-purple.webp',
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                if (value)
                                  const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )))
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        InkWell(
                          onTap: () async {
                            final retValue =
                                await createWalletAddress('polygon');

                            if (retValue != null) {
                              Future.delayed(
                                Duration.zero,
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CoinAddressPage(
                                      address: retValue,
                                      currencyLink:
                                          "https://wiki.polygon.technology/img/polygon-logo.png",
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
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
                                      "https://wiki.polygon.technology/img/polygon-logo.png",
                                      height: 40,
                                      width: 40,
                                    ),
                                    10.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          color: Colors.black,
                                          text: 'Polygon',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TextView(
                                          color: Pallets.greyColor,
                                          text: '0.0000000 MATIC',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (value)
                                  const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ))),
                              ],
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        InkWell(
                          onTap: () async {
                            final retValue =
                                await createWalletAddress('litecoin');

                            if (retValue != null) {
                              Future.delayed(
                                Duration.zero,
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CoinAddressPage(
                                      address: retValue,
                                      currencyLink:
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Litecoin_Logo.jpg/1200px-Litecoin_Logo.jpg?20190210221207",
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
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
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Litecoin_Logo.jpg/1200px-Litecoin_Logo.jpg?20190210221207",
                                      height: 40,
                                      width: 40,
                                    ),
                                    10.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          color: Colors.black,
                                          text: 'Litecoin',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TextView(
                                          color: Pallets.greyColor,
                                          text: '0.0000000 LTC',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (value)
                                  const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
