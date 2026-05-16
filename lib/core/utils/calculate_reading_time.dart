// File: lib/core/utils/calculate_reading_time.dart
// Purpose: Shared core utility, theme, network, or error handling code.

int calculateReadingTime(String content) {
  final wordsCount = content.split(RegExp(r"\s+")).length;
  final readingTime = (wordsCount / 200).ceil();
  return readingTime;
}
