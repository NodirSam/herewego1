import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import '../services/rtdb_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id="home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  Future _openDetail() async{
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context){
          return new DetailPage();
        }
    ));
    if(results != null && results.containsKey("data")){
      print(results['data']);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async {
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((posts) => {
      _respPosts(posts),
    });
  }

  _respPosts(List<Post> posts){
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Post"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white,),
            onPressed: (){
              AuthService.signOutUser(context);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i){
          return itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_openDetail(),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }

  Widget itemOfList(Post post){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.firstname, style: TextStyle(color: Colors.black, fontSize: 20),),
              SizedBox(width: 5,),
              Text(post.lastname, style: TextStyle(color: Colors.black, fontSize: 20),),
            ],
          ),
          SizedBox(height: 10,),
          Text(post.data, style: TextStyle(color: Colors.black, fontSize: 20),),
          SizedBox(height: 10,),
          Text(post.content, style: TextStyle(color: Colors.black, fontSize: 20),),
        ],
      ),
    );
  }
}
