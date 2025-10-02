import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/core/utils/app_preferences.dart';

import 'login_state.dart';

import '../../../domain/repositories/auth_repo.dart'; // FIXED: Import abstract AuthRepo (not imp)

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo; // FIXED: Use abstract AuthRepo (not AuthRepoImp)

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());

    final result = await authRepo
        .signInWithGoogle(); // Calls abstract method (implemented in AuthRepoImp)

    result.fold((exception) => emit(LoginFailure(exception.toString())), (
      userCredential,
    ) async {
      if (await AppPreferences.isFirstLaunch()) {
        await AppPreferences.setOnboardingCompleted();
      }
      emit(LoginSuccess(userCredential));
    });
  }
}
