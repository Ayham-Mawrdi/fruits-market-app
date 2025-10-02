import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../di/injection_container.dart';
import '../../manager/profile_bloc/bloc/profile_bloc.dart';
import '../../manager/profile_bloc/bloc/profile_event.dart';
import 'widgets/profile_view_body.dart';

import '../../../domain/uescases/get_user_profile_usecase.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(sl<GetUserProfileUseCase>())..add(LoadProfile()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: '', leadingIcon: const Icon(null)),
        body: SingleChildScrollView(child: const ProfileViewBody()),
      ),
    );
  }
}
