import 'package:hive/hive.dart';

class Blogmodel {
  final String id;
  final String image_url;
  final String title;
  bool isFavorite;
  

  Blogmodel({
    required this.id,
    required this.image_url,
    required this.title,
    this.isFavorite = false,
  });

  factory Blogmodel.fromJson(Map<String, dynamic> json) {
    return Blogmodel(
      id: json['id'] as String,
      image_url: json['image_url'] as String,
      title: json['title'] as String,
    );
  }
}



class BlogmodelAdapter extends TypeAdapter<Blogmodel> {
  @override
  final int typeId = 0; // Assign a unique ID to your adapter

  @override
  Blogmodel read(BinaryReader reader) {
    return Blogmodel(
      id: reader.readString(),
      image_url: reader.readString(),
      title: reader.readString(),
      isFavorite: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Blogmodel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.image_url);
    writer.writeString(obj.title);
    writer.writeBool(obj.isFavorite);
  }
}



