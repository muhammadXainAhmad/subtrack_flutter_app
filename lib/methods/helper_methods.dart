import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formatPKR(double amount) {
  final formatter = NumberFormat('#,###');
  return "PKR ${formatter.format(amount)}";
}

Future<void> openLink(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Color hexToColor(String hexString) {
  return Color(int.parse(hexString.replaceAll("#", "0xFF")));
}
