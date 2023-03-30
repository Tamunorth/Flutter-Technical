import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_technical_assessment/pallets.dart';
import 'package:flutter_technical_assessment/presentation/pages/balance/balance_page.dart';
import 'package:flutter_technical_assessment/presentation/widgets/sized_box.dart';
import 'package:flutter_technical_assessment/presentation/widgets/text_view.dart';

class CoinAddressPage extends StatefulWidget {
  const CoinAddressPage(
      {super.key, required this.address, required this.currencyLink});

  final String address;
  final String currencyLink;

  @override
  CoinAddressPageState createState() => CoinAddressPageState();
}

class CoinAddressPageState extends State<CoinAddressPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
    scaffoldKey.currentState?.dispose();
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
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              20.verticalSpace,
              Image.network(
                widget.currencyLink,
                height: 40,
                width: 40,
              ),
              20.verticalSpace,
              TextView(
                text: 'Scan the QR code to get Receive address',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              20.verticalSpace,
              Center(
                child: CustomPaint(
                  painter: QrPainter(
                      data: widget.address,
                      options: const QrOptions(
                          shapes: QrShapes(
                              darkPixel:
                                  QrPixelShapeRoundCorners(cornerFraction: .5),
                              frame:
                                  QrFrameShapeRoundCorners(cornerFraction: .25),
                              ball:
                                  QrBallShapeRoundCorners(cornerFraction: .25)),
                          colors: QrColors(
                              dark: QrColorLinearGradient(colors: [
                            Color.fromARGB(255, 255, 0, 0),
                            Color.fromARGB(255, 0, 0, 255),
                          ], orientation: GradientOrientation.leftDiagonal)))),
                  size: const Size(350, 350),
                ),
              ),
              20.verticalSpace,
              TextView(
                text: 'Your Address',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              20.verticalSpace,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallets.greyColor, width: 1),
                ),
                child: Center(
                  child: TextView(
                    color: Pallets.blueColor,
                    text: widget.address,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.address))
                            .then((value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Address Copied to clipboard'),
                            ),
                          );
                        });
                      },
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
                            text: 'Copy Address',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  24.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BalancePage(),
                          ),
                        );
                      },
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
                            text: 'See Balance',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
