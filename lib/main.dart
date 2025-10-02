import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/di/injection_container.dart' as di;
import 'package:fruits_market/core/utils/app_preferences.dart';
import 'package:fruits_market/core/utils/hive_service.dart';
import 'package:fruits_market/features/auth/presentation/pages/login/login_view.dart';
import 'package:fruits_market/features/cart/data/models/cart_item_model.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/cart/presentation/pages/cart_page.dart';
import 'package:fruits_market/features/favourite/presentation/pages/favourite_view.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import 'package:fruits_market/features/home/presentation/pages/mainPage/main_page_view.dart';
import 'package:fruits_market/features/onBoard/presentation/on_boarding_view.dart';
import 'package:fruits_market/features/splash/presentation/splsh_veiw.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  // Initialize DI
  await di.init();

  // Set user ID if user is logged in
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    di.sl<HiveService>().setUserId(user.uid);
  }

  runApp(const FruitsMarket());
}

class FruitsMarket extends StatelessWidget {
  const FruitsMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<FavoritesBloc>()),
        BlocProvider(create: (_) => di.sl<CartBloc>()),
      ],
      child: GetMaterialApp(
        // Use GetMaterialApp for GetX navigation
        theme: ThemeData(useMaterial3: true),
        title: 'Fruit Market',
        debugShowCheckedModeBanner: false,
        home: const AppRouter(), // Custom router widget to handle logic
        // Optional: Define named routes if needed
        getPages: [
          GetPage(name: '/splash', page: () => SplshVeiw()),
          GetPage(name: '/onboarding', page: () => const OnBoardingView()),
          GetPage(name: '/login', page: () => const LoginView()),
          GetPage(name: '/main', page: () => const MainpageView()),
          GetPage(name: '/shopping_cart', page: () => const CartPage()),
          GetPage(name: '/favorite', page: () => const FavouriteView(),)
        ],
      ),
    );
  }
}

// Custom Router: Checks auth and first-launch flag to decide starting screen
class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(), // Async check
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a simple loader while checking
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const LoginView();
        }

        return snapshot.data ?? const LoginView();
      },
    );
  }

  Future<Widget> _getInitialScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const MainpageView();
    }

    final isFirst = await AppPreferences.isFirstLaunch();
    if (isFirst) {
      return const SplshVeiw();
    } else {
      return const SplshVeiw();
    }
  }
}
