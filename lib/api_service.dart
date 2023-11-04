import 'dart:async';
import 'dart:convert';
import 'package:blog_tapestry/Blogmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' ;

class ApiService {

 
      


 final Apibox = 'api_data';
void initbox()async{
  await Hive.openBox(Apibox);
} 

Future<List<Blogmodel>> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
      final posts = await Hive.box(Apibox).get('blogs');
if(
  posts.isNotEmpty
)
{
    final List<dynamic> result = jsonDecode(posts)['blogs'];
      final List<Blogmodel> blogs = result
            .map((json) => Blogmodel.fromJson(json))
            .toList();

 print('Posts $posts');

  
  return blogs;
}else{
  try {
      final response = await get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
 await Hive.box(Apibox).put('blogs',response.body);  
        final List<dynamic> result = jsonDecode(response.body)['blogs'];

 

// print('hello ${posts.put('posts', result)}');
  // Make sure your Blogmodel.fromJson() constructor is correctly defined.
        // Map the response data to Blogmodel objects
        final List<Blogmodel> blogs = result
            .map((json) => Blogmodel.fromJson(json))
            .toList();

        // await Hive.box(Apibox).put('blogs',blogs);  
 print('result $blogs');


        return blogs;
      } else {
        print('Request failed with status code: ${response.statusCode}');
        throw Exception('Response data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch blogs: $e');
    }
}
    
  }
//  List<Blogmodel> _cachedData = [];
// Future<List<Blogmodel>> fetchBlogs() async {
//     const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
//     const String adminSecret =
//         '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

//     try {
//       final response = await get(Uri.parse(url), headers: {
//         'x-hasura-admin-secret': adminSecret,
//       });

//       if (response.statusCode == 200) {
//         final List<dynamic> result = jsonDecode(response.body)['blogs'];

//         // Map the response data to Blogmodel objects
//         final List<Blogmodel> blogs = result
//             .map((json) => Blogmodel.fromJson(json))
//             .toList(); // Make sure your Blogmodel.fromJson() constructor is correctly defined.

//         // Update the cached data
//         _cachedData = blogs;

//         return blogs;
//       } else {
//         print('Request failed with status code: ${response.statusCode}');
//         throw Exception('Response data: ${response.body}');
//       }
//     } catch (e) {
//       // Handle the case when there is no internet connection
//       if (_cachedData.isNotEmpty) {
//         // If there's previously cached data, return it
//         return _cachedData;
//       } else {
//         // If there's no internet connection and no cached data, throw an exception
//         throw Exception('Failed to fetch blogs: $e');
//       }
//     }
//   }
}
 

