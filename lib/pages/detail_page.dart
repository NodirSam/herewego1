import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/prefs_service.dart';
import '../services/rtdb_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const String id="detail_page";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dataController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String data = dataController.text.toString();
    String content = contentController.text.toString();
    if(firstname.isEmpty || content.isEmpty || data.isEmpty || lastname.isEmpty) return;
    _apiAddPost(firstname, lastname, content, data);
  }

  _apiAddPost(String firstname, String lastname, String content, String data) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(firstname: firstname, lastname: lastname, userId: id.toString(), content: content, data: data.toString(),)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost(){
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 15,),
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                  hintText: "Firstname",
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                  hintText: "Lastname",
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                  hintText: "Data",
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.deepOrange,
                child: TextButton(
                  onPressed: ()=>_addPost(),
                  child: Text("Add", style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}