import 'package:intl/intl.dart';

String formatPKR(double amount) {
  final formatter = NumberFormat('#,###');
  return "PKR ${formatter.format(amount)}";
}
