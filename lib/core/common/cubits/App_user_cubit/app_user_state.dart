// File: lib/core/common/cubits/App_user_cubit/app_user_state.dart
// Purpose: Shared core utility, theme, network, or error handling code.

part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  AppUserLoggedIn({required this.user});
}
