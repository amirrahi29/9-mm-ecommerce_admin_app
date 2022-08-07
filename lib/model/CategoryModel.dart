class CategoryModel{

  int? uid;
  String? title;
  String? description;
  String? catImage;
  String? date;

  CategoryModel({this.uid,this.title,this.description,this.catImage,this.date});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      catImage: json['catImage'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      "uid":uid,
      "title":title,
      "description":description,
      "catImage":catImage,
      "date":date,
    };
  }

}