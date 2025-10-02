import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/profile_bloc/bloc/profile_bloc.dart';

import '../../../manager/profile_bloc/bloc/profile_state.dart';
import 'decoration_details_wdiget.dart';

class DecorationDetailsWidgetWithBloc extends StatefulWidget {
  const DecorationDetailsWidgetWithBloc({super.key});

  @override
  State<DecorationDetailsWidgetWithBloc> createState() =>
      _DecorationDetailsWidgetWithBlocState();
}

class _DecorationDetailsWidgetWithBlocState
    extends State<DecorationDetailsWidgetWithBloc> {
  // In ProfileViewBody build method
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;
          return DecorationDetailsWdiget(
            name: profile.name,
            email: profile.email,
          );
        } else if (state is ProfileError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('No profile data'));
      },
    );
  }
}
