// File: lib/core/utils/format_date.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:intl/intl.dart';

String formateDAte(DateTime datetime) {
  return DateFormat("d MMM, yyyy").format(datetime);
}
