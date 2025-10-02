import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/cart/presentation/pages/cart_page.dart';
import 'package:fruits_market/features/favourite/presentation/pages/favourite_view.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_event.dart';
import '../../../../../auth/presentation/pages/profile/profile_view.dart';
import '../../../../domain/use_cases/get_items_by_category_usecase.dart';
import '../../../../../../core/constant.dart';
import '../../../../../../core/utils/sized_config.dart';
import '../../../../../../core/widgets/custom_search_bar.dart';
import '../../../../../../di/injection_container.dart';
import '../../../../domain/entities/category.dart';
import '../../../manager/bloc/home_bloc.dart';
import 'header_home.dart';
import 'main_page_view_body_with_bloc.dart';

class MainPageViewBody extends StatefulWidget {
  const MainPageViewBody({super.key});

  @override
  State<MainPageViewBody> createState() => _MainPageViewBodyState();
}

class _MainPageViewBodyState extends State<MainPageViewBody> {
  int _currentIndex = 0;
  late final HomeBloc _homeBloc; // Bloc instance for direct access
  late final FavoritesBloc _favoritesBloc; // Bloc instance for direct access
  late final CartBloc _cartBloc; // Bloc instance for direct access

  @override
  void initState() {
    super.initState(); // Initialize SizeConfig once here (not in build)
    // Create Bloc once with DI
    _homeBloc = HomeBloc(sl<GetItemsByCategoryUseCase>());
    _favoritesBloc = sl<FavoritesBloc>();
    _cartBloc = sl<CartBloc>();
    // Load initial data
    _homeBloc.add(const CategorySelected(Category.vegetables));
  }

  @override
  void dispose() {
    _homeBloc.close();
    _favoritesBloc.close();
    _cartBloc.close();
    super.dispose();
  }

  // Method to handle tab taps DIRECTLY (no context needed) - for category tabs inside home
  void _handleTabTap(int index) {
    Category newCategory;
    switch (index) {
      case 0:
        newCategory = Category.vegetables;
        break;
      case 1:
        newCategory = Category.fruits;
        break;
      case 2:
        newCategory = Category.organic;
        break;
      default:
        newCategory = Category.vegetables;
    }
    // Direct add to bloc - no context!
    _homeBloc.add(CategorySelected(newCategory));
  }

  void _onNavigationBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 2) {
      // Reload favorites when switching to favourite tab
      _favoritesBloc.add(LoadFavoritesEvent());
    }
  }

  // Widget builder for each tab to avoid repetition
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0: // Home
        return MainPageViewBodyWithBloc(
          bloc: _homeBloc,
          onTabTap: _handleTabTap,
          cartBloc: _cartBloc,
        );
      case 1: // Cart
        return const CartPage();
      case 2: // Favourite
        return const FavouriteView();
      case 3: // Profile
        return const ProfileView();
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeBloc),
        BlocProvider.value(value: _favoritesBloc),
        BlocProvider.value(value: _cartBloc),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (always visible)
                if (_currentIndex == 0) const HeaderHome(),
                // Use IndexedStack for efficient tab switching (preserves state)
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: [
                      // Home tab (index 0) - uses Bloc
                      _buildTabContent(0),
                      _buildTabContent(1),
                      _buildTabContent(2),
                      _buildTabContent(3),
                    ],
                  ),
                ),
              ],
            ),
            if (_currentIndex == 0)
              Positioned(
                top: SizeConfig.screenHeight! * 0.115,
                left: 8,
                right: 8,
                child: const CustomSearchBar(),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 28,
          selectedItemColor: kMainColor,
          currentIndex: _currentIndex,
          onTap: _onNavigationBarItemTapped,
          type: BottomNavigationBarType.fixed,
          items: items,
        ),
      ),
    );
  }
}
