import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class DetailScreen extends StatelessWidget {
  final Data;

  const DetailScreen({super.key, required this.Data});
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: CachedNetworkImage(
        imageUrl: Data.image_url,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),// Build your detail screen UI using selectedBlog,
    );
  }
}