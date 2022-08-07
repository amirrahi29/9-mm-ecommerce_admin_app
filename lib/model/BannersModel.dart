class BannersModel{

  int? uid;
  String? title;
  String? description;
  String? bannerImage;
  String? date;

  BannersModel({this.uid,this.title,this.description,this.bannerImage,this.date});

  factory BannersModel.fromJson(Map<String, dynamic> json){
    return BannersModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['bannerImage'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid':uid,
      'title':title,
      'description':description,
      'bannerImage':bannerImage,
      'date':date,
    };
  }

}