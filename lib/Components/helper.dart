import 'package:intl/intl.dart';

String formatRupiah(num number) {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatCurrency.format(number);
}
