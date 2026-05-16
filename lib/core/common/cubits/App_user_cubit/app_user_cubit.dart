// File: lib/core/common/cubits/App_user_cubit/app_user_cubit.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:blogs_demo/core/common/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
