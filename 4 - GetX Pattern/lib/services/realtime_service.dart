import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getxpattern4/models/post_model.dart';

class RealtimeDB{
  static final _database = FirebaseDatabase.instance.ref();
  static const String apiPost = 'posts';

  static Future<List<Post>> GET(String id) async {
    List<Post> list = [];
    Query _query = _database.child(apiPost).orderByChild('ID').equalTo(id);
    DatabaseEvent result = await _query.once();
    for (var element in result.snapshot.children) {
      list.add(Post.fromJson(Map<String,dynamic>.from(element.value as Map<dynamic,dynamic>)));
    }
    // list = result.snapshot.children.map((json) => Post.fromJson(Map<String, dynamic>.from(json.value as Map))).toList();
    print('Response: $list');
    return list;
  }

  static Future<Stream<DatabaseEvent>> POST(Post post) async {
    _database.child(apiPost).push().set(post.toJson());
    return _database.onChildAdded;
  }

  static PUT(Post post,String key,BuildContext context)async{
    _database.child("post").child(key).set(post.toJson());
    Navigator.pop(context);
  }

  static DELETE({key}){
    _database.child(key).remove();
  }
}