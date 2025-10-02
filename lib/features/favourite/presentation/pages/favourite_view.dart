import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/core/constant.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_event.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_state.dart';

import '../widgets/favourite_body.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  void initState() {
    super.initState();
    // Load favorites on init
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Favourites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kMainColor,
        // leading: Icon(MaterialIcons.arrow_back),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favourites yet! Start adding items to your favourites.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return FavouriteBody(favorites: state.favorites);
          } else if (state is FavoritesError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('Load your favourites'));
        },
      ),
    );
  }
}
