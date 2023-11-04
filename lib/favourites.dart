import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Blogmodel.dart';




class FavoriteController extends StateNotifier<List<Blogmodel>> {
  FavoriteController() : super([]);

  void addToFav(int index, List<Blogmodel> data) {
    data[index].isFavorite = true;
    final result = data.where((element) => element.isFavorite==true).toList();
    state = [...result];
  }

  void removeFromFav(String id, ) {
    
    for (final item in state) {
      if (item.id == id) {
        item.isFavorite = false;
      }
    }
    final result = state.where((element) => element.isFavorite).toList();
    state = [...result];
  }


  }
