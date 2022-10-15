class Post {
  String userId;
  String firstname;
  String lastname;
  String content;
  String data;
  //String img_url;


  Post({required this.userId, required this.firstname, required this.lastname, required this.content, required this.data});

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        data = json['data'],
        content = json['content'];
  //img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstname': firstname,
    'lastname': lastname,
    'data': data,
    'content': content,
    //'img_url': img_url,
  };
}