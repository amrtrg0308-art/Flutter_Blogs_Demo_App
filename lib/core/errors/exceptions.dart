// File: lib/core/errors/exceptions.dart
// Purpose: Shared core utility, theme, network, or error handling code.

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
