// File: lib/core/usecase/use_case.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
