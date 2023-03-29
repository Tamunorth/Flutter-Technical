import 'package:flutter/cupertino.dart';

extension SizeExtension on num {
  Widget get verticalSpace => SizedBox(height: toDouble());

  Widget get horizontalSpace => SizedBox(width: toDouble());
}
