import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';

import '../../../../../../core/utils/sized_config.dart';
import '../../../../domain/entities/category.dart';
import '../../../manager/bloc/home_bloc.dart';
import 'build_section_content.dart';
import 'text_categories_strip.dart';

class MainPageViewBodyWithBloc extends StatelessWidget {
  final HomeBloc bloc;
  final void Function(int) onTabTap; // Callback for category taps
  final CartBloc cartBloc;

  const MainPageViewBodyWithBloc({
    super.key,
    required this.bloc,
    required this.onTabTap,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc, // Use passed bloc instance
      builder: (context, state) {
        // Handle states
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.05),
                // Categories Strip - Use passed callback
                TextCategoriesStrip(
                  fTitle: Category.vegetables.displayName,
                  sTitle: Category.fruits.displayName,
                  tTitle: Category.organic.displayName,
                  selectedIndex: state.selectedCategory.index,
                  onTap: onTabTap, // Direct method passed from parent
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.035),
                // Content from state
                BuildSectionContent(
                  title1: state.sectionModel.title1,
                  subtitle1: state.sectionModel.subtitle1,
                  title2: state.sectionModel.title2,
                  subtitle2: state.sectionModel.subtitle2,
                  items: state.items,
                  cartBloc: cartBloc,
                ),
              ],
            ),
          );
        }
        return const SizedBox(); // Default empty
      },
    );
  }
}
