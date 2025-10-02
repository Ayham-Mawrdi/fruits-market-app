import 'package:fruits_market/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruits_market/features/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/remove_from_cart_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/update_cart_quantity_usecase.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/home/data/repositories/favorites_repository_impl.dart';
import 'package:fruits_market/features/home/domain/repositories/favorites_repository.dart';
import 'package:fruits_market/features/home/domain/use_cases/get_favorites_usecase.dart';
import 'package:fruits_market/features/home/domain/use_cases/toggle_favorite_usecase.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import '../core/utils/hive_service.dart';
import '../features/auth/data/data_sources/local_data_source/local_data_source.dart';
import '../features/auth/data/data_sources/remote_data_source/firebase_auth_data_source.dart';
import '../features/auth/data/data_sources/remote_data_source/firebase_user_data_source.dart';
import '../features/auth/data/repositories/auth_repo_imp.dart';
import '../features/auth/domain/repositories/auth_repo.dart';
import '../features/auth/domain/uescases/get_user_profile_usecase.dart';
import '../features/home/data/data_source/home_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/use_cases/get_items_by_category_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<HiveService>(() => HiveService());

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      hiveService: sl<HiveService>(),
      homeRepository: sl<HomeRepository>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(
    () => GetFavoritesUseCase(sl(), sl<HomeRepository>()),
  );

  // BLoC
  sl.registerFactory(
    () => FavoritesBloc(toggleFavoriteUseCase: sl(), getFavoritesUseCase: sl()),
  );

  // Auth Data Sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(),
  );
  sl.registerLazySingleton<FirebaseUserDataSource>(
    () => FirebaseUserDataSourceImpl(),
  );
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // Auth Repository (injects data sources – this creates AuthRepoImp instance)
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      sl<FirebaseAuthDataSource>(),
      sl<FirebaseUserDataSource>(),
      sl<LocalDataSource>(),
      sl<HiveService>(),
    ),
  );

  // Auth Use Cases
  sl.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(sl<AuthRepo>()),
  );

  // Home Feature (unchanged)
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeDataSource>()),
  );
  sl.registerLazySingleton<GetItemsByCategoryUseCase>(
    () => GetItemsByCategoryUseCase(sl<HomeRepository>()),
  );

  // Cart Feature
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl<HiveService>()),
  );
  sl.registerLazySingleton(() => AddToCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl<CartRepository>()));
  sl.registerFactory(
    () => CartBloc(
      addToCartUseCase: sl<AddToCartUseCase>(),
      getCartItemsUseCase: sl<GetCartItemsUseCase>(),
      removeFromCartUseCase: sl<RemoveFromCartUseCase>(),
      updateCartQuantityUseCase: sl<UpdateCartQuantityUseCase>(),
    ),
  );
}
