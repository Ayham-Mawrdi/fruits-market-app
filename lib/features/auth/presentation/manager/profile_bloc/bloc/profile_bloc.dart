import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/uescases/get_user_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileBloc(this.getUserProfileUseCase) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final uid = FirebaseAuth.instance.currentUser ?.uid;
      if (uid == null) {
        emit(ProfileError('No user logged in'));
        return;
      }
      final result = await getUserProfileUseCase(uid);
      result.fold(
        (failure) => emit(ProfileError(failure.toString())),
        (profile) => emit(ProfileLoaded(profile!)),
      );
    });
  }
}