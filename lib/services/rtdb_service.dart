import 'package:firebase_database/firebase_database.dart';

import '../model/post_model.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPosts(String id) async {
    List<Post> items = [];
    //   Query _query = _database.ref.child("posts").orderByChild("userId").equalTo(id);
    //   var snapshot = await _query.once();
    //   var result = snapshot.snapshot.children;
    //
    //   for(var item in result) {
    //     items.add(Post.fromJson(Map<String, dynamic>.from(item)));
    //   }
    //   return items;
    // }
    Query query = _database.child("posts");
    await query.once().then((snapshot) {
      final v = snapshot.snapshot.children;
      for(var i in v){
        Map map = i.value as Map;
        items.add(Post(userId:map['userId'],content: map['content'], firstname:map['firstname'], lastname: map["lastname"], data: map["data"],));
      }
    });
    return items;
  }

}