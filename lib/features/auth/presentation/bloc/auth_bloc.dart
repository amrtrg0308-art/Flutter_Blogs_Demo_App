// ignore_for_file: avoid_print

import 'package:blogs_demo/core/common/cubits/App_user_cubit/app_user_cubit.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/core/common/entities/user.dart';
import 'package:blogs_demo/features/auth/domain/usecases/current_user.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_logout.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  }) : _currentUser = currentUser,
       _userSignUp = userSignUp,
       _userLogin = userLogin,
       _appUserCubit = appUserCubit,
       _userLogout = userLogout,
       
       super(AuthInitial()) {
    // Default state for any event while a request is pending.
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onUserLoggedIn);
    on<AuthUserLogout>(_onUserLogout);
  }

  void _onUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    print('AuthSignUp event triggered with email: ${event.email}');
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) {
        print('Sign up failed:=== ${l.message}');
        emit(AuthFailure(message: l.message));
      },
      (user) {
        print('Sign up success with uid: $user');
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    // Attempt to sign in the user with credentials from the login form.
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) {
        print('Login failed: ${l.message}');
        emit(AuthFailure(message: l.message));
      },
      (user) {
        print('Login success with user: ${user.id}');
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }

  Future<void> _onUserLogout(AuthUserLogout event, Emitter emit) async {
     final res = await _userLogout(NoParams());
     res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        _appUserCubit.updateUser(null);
        emit(AuthInitial());
      }
     );
  }
}
