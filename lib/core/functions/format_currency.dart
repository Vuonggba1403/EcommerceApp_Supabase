import 'package:intl/intl.dart';

String formatCurrency(dynamic value) {
  if (value == null) return "0";
  final number = double.tryParse(value.toString()) ?? 0;
  return NumberFormat("#,###", "vi_VN").format(number);
}
