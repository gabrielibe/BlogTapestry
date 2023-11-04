import 'dart:developer';

import 'package:blog_tapestry/Blogmodel.dart';
import 'package:blog_tapestry/check.dart';
import 'package:blog_tapestry/profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api_service.dart';
import 'detail_screen.dart';
import 'favourites.dart';

final ApiData = Provider<ApiService>((ref) => ApiService());

final Blogdata = FutureProvider<List<Blogmodel>>((ref) {
  return ref.read(ApiData).fetchBlogs();
});

final listFavProvider =
    StateNotifierProvider<FavoriteController, List<Blogmodel>>(
  (ref) {
    return FavoriteController();
  },
);

void main() async  {
 await Hive.initFlutter();
Hive.registerAdapter<Blogmodel>(BlogmodelAdapter());
 ApiService().initbox();
 await Hive.openBox('myBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Data = ref.watch(Blogdata);
    final listFav = ref.watch(listFavProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
         floatingActionButton: FloatingActionButton(
  onPressed: () {
    for (final item in listFav) {
      log('ITEM IN CARD $item');
      print(item.id);

    }
  },
  child: Container(
    padding: const EdgeInsets.all(8),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.favorite,
          size: 32,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ClipOval(
            child: Container(
              width: 22,
              height: 22,
              color: Colors.red,
              child: Center(
                child: Text(listFav.length.toString()),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

          appBar: AppBar(
            title: const Text('help'),
          ),
          body: Center(
            child: Data.when(data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => WorkoutScreen()
                                  
                                  ));
                        },
                        child: Column(
                          children: [
                            Container(
                              child:  CachedNetworkImage(
        imageUrl: data[index].image_url,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
                            ),
                            Text('${data[index].title} '),
                            GestureDetector(
                                   onTap: (){
                      //  data[index].isFavorite?ref.read(listFavProvider.notifier).removeFromFav(data[index].id, index, data): ref.read(listFavProvider.notifier).addToFav(index, data);
                    
                        print(data[index].id);
                      },
                         
                                child: IconButton(
                              onPressed: data[index].isFavorite
                                  ? () {
                                      ref
                                          .read(listFavProvider.notifier)
                                          .removeFromFav(data[index].id);
                                    }
                                  : () {
                                      ref
                                          .read(listFavProvider.notifier)
                                          .addToFav(index, data);
                                    },
                              icon: data[index].isFavorite
                                  ? const Icon(
                                      Icons.favorite,
                                      size: 32,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_outline,
                                      size: 32,
                                      color: Colors.grey.shade600,
                                    ),
                            ),),
                          ],
                        ),
                      ),
                    );
                  }));
            }, error: (
              error,
              stackTrace,
            ) {
              print('Stack Trace: $stackTrace');

              return Text('Error: $error');
            }, loading: (() {
              return const CircularProgressIndicator();
            })),
          ),
        ));
  }
}
